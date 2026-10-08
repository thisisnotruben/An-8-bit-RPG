@tool
class_name Character extends CharacterBody2D

@onready var anim: AnimationPlayer = $anim_player
@onready var anim_tree: AnimationTree = $anim_tree
@onready var nav_agent: NavigationAgent2D = $nav_agent
@onready var img: Sprite2D = $img
@onready var body: CollisionShape2D = $body
@onready var snd: AudioStreamPlayer2D = $snd
@onready var snd_shoot: AudioStreamPlayer2D = $snd_shoot
@onready var snd_melee: AudioStreamPlayer2D = $snd_melee
@onready var hit_scan_shoot: RayCast2D = $hit_shoot_cast
@onready var hit_scan_melee: RayCast2D = $hit_melee_cast
@onready var item_behaviors: Node = $item_behaviors
@onready var screen_notifier: VisibleOnScreenNotifier2D = $screen_notifier
@onready var sight: Area2D = $sight

@onready var behavior: BTPlayer = $behavior
@onready var health: StatComponent = $health
@onready var health_regen: StatRegenComponent = $health_regen
@onready var mana: StatComponent = $mana
@onready var mana_regen: StatRegenComponent = $mana_regen
@onready var ability: StatComponent = $ability
@onready var ability_regen: StatRegenComponent = $ability_regen
@onready var fsm: FsmCharacter = $fsm
@onready var dialogue_actionable: DialogueActionable2D = $dialogue_actionable
@onready var dialogue_state_context: DialogueStateContext = $dialogue_state_context
@onready var threat: ThreatService = $threat_service

@export_tool_button('Refresh Builder', 'Callable') var refresh_build = \
	func(): if unit: unit.init(self)
@export var unit: CharacterBuilder:
	set(value):
		if Engine.is_editor_hint():
			unit = value
		else:
			if not is_node_ready():
				await ready
			unit = value
			#if value:
				#unit = value.duplicate()
				#unit.make_unique()
		if value:
			value.init(self)
		if not Engine.is_editor_hint():
			# Delay to allow scene setup
			await get_tree().create_timer(1.0).timeout
			behavior.active = value != null

var target: Character:
	set(value):
		target = null if unit and unit.non_aggresive else value

var is_inventory_full := func(): return true
var is_spellbook_full := func(): return true

var focused_dialogue_quest: QuestData

@warning_ignore('unused_signal')
signal died(from_threat)
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
		_conserve_performance(not screen_notifier.is_on_screen())

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

func _on_health_changed(current: int, _max: int, old_value: int, aggresor: Character):
	behavior.blackboard.set_var(LimboVarLib.HURT, current < old_value)
	behavior.blackboard.set_var(LimboVarLib.FLEE_AGGRESSOR_POS, aggresor.global_position)

func _on_sight_body_entered(other_npc: Node2D):
	if other_npc != self and unit.npc:
		if is_foe(other_npc):
			aggro(other_npc)
		elif target:
			other_npc.aggro(target)

func _on_dialogue_actionable_body_exited(_body: Node2D) -> void:
	if unit.npc and focused_dialogue_quest \
	and is_instance_valid(dialogue_actionable.dialogue_resource) \
	and is_instance_valid(dialogue_actionable.dialogue_balloon):
		var character := _body as Character
		if character and not character.unit.npc:
			DialogueManager.dialogue_ended.emit(dialogue_actionable.dialogue_resource)
			dialogue_actionable.dialogue_balloon.queue_free()

func _on_threat_service_on_first_threat_added() -> void:
	behavior.blackboard.set_var(LimboVarLib.HAS_THREATS, true)

func _on_threat_service_on_no_threats() -> void:
	behavior.blackboard.set_var(LimboVarLib.HAS_THREATS, false)
	target = null

func _on_screen_notifier_screen_entered() -> void:
	_conserve_performance(false)
	
func _on_screen_notifier_screen_exited() -> void:
	_conserve_performance(true)

func _conserve_performance(conserve: bool):
	conserve = not conserve
	set_physics_process(conserve)
	set_process_input(conserve)
	set_process(conserve)
	#behavior.active = conserve
	anim_tree.active = conserve

func _set_player_input_vars():
	if not unit or unit.npc:
		return

	var input_state := 'idle'
	if Input.get_vector('move_left', 'move_right', 'move_up', 'move_down').length() > 0.0:
		input_state = 'move'
	elif Input.is_action_just_pressed('attack'):
		var mouse_pos := get_global_mouse_position()
		hit_scan_melee.look_at(mouse_pos)
		hit_scan_shoot.look_at(mouse_pos)
		# TODO: will likely have to change this in regards of melee or range
		# and what the player currently has equipped to attack
		if hit_scan_melee.get_collider() or hit_scan_shoot.get_collider():
			input_state = 'attack'
		
	behavior.blackboard.set_var(LimboVarLib.INPUT_STATE, input_state)

func _on_health_amount_notify(amount: int, aggressor: Character):
	if unit.npc and amount < 0:
		target = threat.threat_changed(aggressor, amount)

func inventory_modify(item_type: BaseItem.Type, add: bool) -> bool:
	var item: Item = ItemService.get_item(item_type)
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
		var payload := {'type': item_type, 'add': add}
		if item.category == BaseItem.Category.SPELL:
			spell_added.emit(payload)
		else:
			inventory_added.emit(payload)

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

func is_foe(_body: Node2D) -> bool:
	var character := _body as Character
	return character \
		and (character.unit.friendly != unit.friendly \
		or (not character.unit.npc and not unit.friendly)) \
		and character.fsm.state != CharacterStates.Type.DEAD

func aggro(_body: Node2D) -> bool:
	var _target := _body as Character
	if unit.npc and not target and _target and not _target.unit.non_aggresive and is_foe(_target):
		target = _target
		sight.get_overlapping_bodies() \
			.filter(func(b): return b != self and not is_foe(b) and not b.target) \
			.map(func(b): b.aggro(_target))
		return true
	return false
	
func on_attacked(aggressor: Character, attack: ModifierAttack):
	threat.add_threat(aggressor)
	health.modify(attack, aggressor)

func get_flee_pos(aggressor_pos := Vector2.ZERO) -> Vector2:
	if aggressor_pos.is_zero_approx():
		return Vector2.ZERO
		
	var theta := randf() * 2 * PI
	var radius := ((sight.get_child(0) as CollisionShape2D).shape as CircleShape2D).radius
	var flee_pos := global_position + Vector2(cos(theta), sin(theta)) * radius
	var opp_attack_dir := global_position + aggressor_pos.direction_to(global_position) * radius

	if global_position.direction_to(opp_attack_dir).dot(global_position.direction_to(flee_pos)) >= 0.0:
		return flee_pos
	return Vector2.ZERO

func notify_projectile_incoming(projectile: Projectile):
	behavior.blackboard.set_var(LimboVarLib.INCOMING_PROJECTILE, projectile)

func set_dialogue(dialogue_res: DialogueResource = null, cue_name := '', alias := '', focused_quest: QuestData = null):
	dialogue_actionable.dialogue_resource = dialogue_res
	dialogue_actionable.dialogue_cue = cue_name
	dialogue_state_context.alias = alias
	focused_dialogue_quest = focused_quest
	
	var dialogue_role := CharacterBuilder.CharaterSideRoles.DIALOGUE
	if dialogue_res:
		if not unit.character_roles.has(dialogue_role):
			unit.character_roles.append(dialogue_role)
	else:
		unit.character_roles.erase(dialogue_role)

func start_dialogue():
	if not unit.npc or not focused_dialogue_quest:
		return
		
	for _body in dialogue_actionable.get_overlapping_bodies():
		var character := _body as Character
		if character and not character.unit.npc:
			QuestState.focused_quest = focused_dialogue_quest
			dialogue_actionable.action()
