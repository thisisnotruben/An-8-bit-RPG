@tool
class_name Character extends CharacterBody2D

@onready var anim: AnimationPlayer = $anim_player
@onready var anim_tree: AnimationTree = $anim_tree
@onready var nav_agent: NavigationAgent2D = $nav_agent
@onready var img: Sprite2D = $img
@onready var snd: AudioStreamPlayer2D = $snd
@onready var snd_shoot: AudioStreamPlayer2D = $snd_shoot
@onready var snd_melee: AudioStreamPlayer2D = $snd_melee
@onready var hit_scan_shoot: RayCast2D = $hit_shoot_cast
@onready var hit_scan_melee: RayCast2D = $hit_melee_cast
@onready var item_behaviors: Node = $item_behaviors

@onready var behavior: BTPlayer = $behavior
@onready var health: StatComponent = $health
@onready var health_regen: StatRegenComponent = $health_regen
@onready var mana: StatComponent = $mana
@onready var mana_regen: StatRegenComponent = $mana_regen
@onready var ability: StatComponent = $ability
@onready var ability_regen: StatRegenComponent = $ability_regen
@onready var fsm: FsmCharacter = $fsm

@export_tool_button('Refresh Builder', 'Callable') var refresh_build = func(): \
	if unit:
		unit.init(self)
@export var unit: CharacterBuilder:
	set(value):
		if not is_node_ready():
			await ready
		if value:
			if Engine.is_editor_hint():
				unit = value
			else:
				unit = value.duplicate_deep(Resource.DEEP_DUPLICATE_ALL)
			value.init(self)
		else:
			unit = null
		behavior.active = value != null

var target: Character = null

var is_inventory_full := func(): return true
var is_spellbook_full := func(): return true

@warning_ignore('unused_signal')
signal died
@warning_ignore('unused_signal')
signal set_player_move_hud_menu_pause(is_hud_panel_visible)
signal on_selected(character: Character)
signal inventory_added(_item)
signal spell_added(_spell)


func _ready():
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process_input(false)
		set_process(false)
	else:
		var fsm_init := {}
		fsm.get_children() \
			.filter(func(s): return s is CharacterState and s.enabled) \
			.map(func(s): fsm_init[s.type] = s)
		fsm.init(fsm_init, {'character': self})

func _physics_process(delta: float):
	fsm.physics_process(delta)
	move_and_slide()

func _process(delta: float):
	fsm.process(delta)
	_set_player_input_vars()

func _input(event: InputEvent):
	fsm.input(event)

func _on_nav_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity

func _on_select_bttn_pressed():
	on_selected.emit(self)

func _on_health_changed(current: int, _max: int, old_value: int):
	behavior.blackboard.set_var(LimboVarLib.HURT, current < old_value)

func _on_sight_body_entered(other_npc: Node2D):
	if other_npc != self:
		if is_foe(other_npc):
			aggro(other_npc)
		elif target:
			other_npc.aggro(target)

func inventory_modify(item_type: BaseItem.Type, add: bool) -> bool:
	var item: Item = ItemDB.get_item(item_type)
	var result := true

	if item.category == BaseItem.Category.SPELL:
		if add and not is_spellbook_full.call():
			unit.spells.append(item_type)
		elif not add and unit.spells.has(item_type):
			unit.spells.erase(item_type)
		else:
			result = false
	elif add and not is_inventory_full.call():
		unit.inventory.append(item_type)
	elif not add and unit.inventory.has(item_type):
		unit.inventory.erase(item_type)
	else:
		result = false

	if result:
		if item.category == BaseItem.Category.SPELL:
			spell_added.emit(item_type, add)
		else:
			inventory_added.emit(item_type, add)

		var item_ability := item as Ability
		if item_ability and item_ability.passive \
		and item_ability.target_type == Ability.TargetType.USER:
			spawn_ability_player(item_ability, self)
	return result

func spawn_ability_player(ability_item: Ability, ability_target: Character):
	var ability_player := (preload('uid://c0nmdbo1fso22').instantiate() \
		as AbilityPlayer).init(ability_item, ability_target)
	item_behaviors.add_child(ability_player)

	ability_item.take_cost(self)
	match ability_item.target_type:
		Ability.TargetType.USER, Ability.TargetType.NONE:
			ability_player.enter()
		Ability.TargetType.TARGET:
			var state_for_ability := CharacterStates.Type.MELEE
			if ability_item.projectile_strategy:
				state_for_ability = CharacterStates.Type.SHOOT

			(fsm.states[state_for_ability] \
				as CharacterState).blackboard.set(LimboVarLib.ABILITY_PLAYER, ability_player)
			fsm.state = state_for_ability

func _set_player_input_vars():
	if not unit or unit.npc:
		return

	var input_state := 'idle'
	if Input.get_vector('move_left', 'move_right', 'move_up', 'move_down').length() > 0.0:
		input_state = 'moveasdsad'
	elif Input.is_action_just_pressed('attack'):
		input_state = 'attack'
	behavior.blackboard.set_var(LimboVarLib.INPUT_STATE, input_state)

func is_foe(_body: Node2D) -> bool:
	return _body is Character and _body.unit.friendly != unit.friendly \
	and _body.fsm.state != CharacterStates.Type.DEAD

func aggro(_body: Node2D) -> bool:
	if unit.npc and not target and is_foe(_body):
		target = _body
		for other_body in $sight.get_overlapping_bodies():
			if other_body != self and not is_foe(other_body) and not other_body.target:
				(other_body as Character).aggro(target)
		return true
	return false

func notify_projectile_incoming(projectile: Projectile):
	behavior.blackboard.set_var(LimboVarLib.INCOMING_PROJECTILE, projectile)
