extends CharacterBody2D
class_name Character

enum CharaterSideRoles { MERCHANT, TRAINER, DIALOGUE, }

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

@onready var fsm: FsmCharacter = $fsm
var state: int:
	set(value):
		fsm.state = value
	get:
		return fsm.state

@onready var behavior: BTPlayer = $behavior
@onready var health: StatComponent = $health
@onready var health_regen: StatRegenComponent = $health_regen
@onready var mana: StatComponent = $mana
@onready var mana_regen: StatRegenComponent = $mana_regen
@onready var ability: StatComponent = $ability
@onready var ability_regen: StatRegenComponent = $ability_regen

@export var character_name := ""
@export var character_roles: Array[CharaterSideRoles] = []
@export var npc_behavior_tree: BehaviorTree = preload("res://resource/limbo_ai_trees/behavior_character_default.tres")

@export var game_hit_flags: GameHitFlags = preload("res://resource/character/hit_flags.tres"):
	set(value):
		game_hit_flags = value
		if not is_node_ready():
			await ready
		value.set_flags(self)

@export var npc := true:
	set(value):
		npc = value
		if not is_node_ready():
			await ready

		nav_agent.avoidance_enabled = value
		$cam.enabled = not value
		game_hit_flags.set_flags(self)
		if value:
			behavior.behavior_tree = npc_behavior_tree
		else:
			behavior.behavior_tree = preload("res://resource/limbo_ai_trees/behavior_character_player.tres")
		behavior.blackboard.set_var("character_var", self)
		behavior.blackboard.set_var("health_var", health.current)
		behavior.blackboard.bind_var_to_property("health_var", health, "current")

@export var friendly: bool:
	set(value):
		friendly = value
		if  not is_node_ready():
			await ready
		game_hit_flags.set_flags(self)

@export var stats: CharacterStats:
	set(value):
		stats = value
		if not is_node_ready():
			await ready
		if value:
			value.set_stats(self)

@export var inventory: Array[Item.Type] = []
@export var spells: Array[Item.Type] = []
@export var drops: Dictionary[int, Item.Type] = {} # int [0 - 100 range] (drop percent)

@export var target: Character = null
@export var gold: int:
	set(value):
		gold = maxi(value, 0)

var is_inventory_full := func(): return true
var is_spellbook_full := func(): return true

@warning_ignore("unused_signal")
signal died
@warning_ignore("unused_signal")
signal set_player_move_hud_menu_pause(is_hud_panel_visible)
signal on_selected(character: Character)
signal inventory_added(_item)
signal spell_added(_spell)


func _ready():
	var fsm_init := {}
	fsm.get_children() \
		.filter(func(s): return s is CharacterState and s.enabled) \
		.map(func(s): fsm_init[s.type] = s)
	fsm.init(fsm_init, {"character": self})

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
	behavior.blackboard.set_var("hurt_var", current < old_value)

func _on_sight_body_entered(other_npc: Node2D):
	if is_foe(other_npc):
		aggro(other_npc)
	elif target:
		other_npc.aggro(target)

func inventory_modify(item_type: BaseItem.Type, add: bool) -> bool:
	var item: Item = ItemDB.get_item_type_data(item_type)
	var result := true

	if item.category == BaseItem.Category.SPELL:
		if add and not is_spellbook_full.call():
			spells.append(item_type)
		elif not add and spells.has(item_type):
			spells.erase(item_type)
		else:
			result = false
	elif add and not is_inventory_full.call():
		inventory.append(item_type)
	elif not add and inventory.has(item_type):
		inventory.erase(item_type)
	else:
		result = false

	if result:
		if item.category == BaseItem.Category.SPELL:
			spell_added.emit(item_type, add)
		else:
			inventory_added.emit(item_type, add)
		spawn_item_behavior(item.behavior)
	return result

func spawn_item_behavior(behavior_tree: BehaviorTree):
	if behavior_tree:
		var item_behavior: ItemBehavior = preload("res://src/item/item_behavior.tscn").instantiate()
		item_behavior.set_behavior_res(behavior_tree, self)
		item_behaviors.add_child(item_behavior)

func _set_player_input_vars():
	if npc:
		return

	var input_state := "idle"
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0.0:
		input_state = "move"
	elif Input.is_action_just_pressed("attack"):
		input_state = "attack"
	behavior.blackboard.set_var("input_state_var", input_state)

func is_foe(_body: Node2D) -> bool:
	return _body is Character and _body.friendly != friendly \
	and _body.fsm.state != CharacterStates.Type.DEAD

func aggro(_body: Node2D) -> bool:
	if npc and not target and is_foe(_body):
		target = _body
		for other_body in $sight.get_overlapping_bodies():
			if other_body != self and not is_foe(other_body) and not other_body.target:
				(other_body as Character).aggro(target)
		return true
	return false

func notify_projectile_incoming(projectile: Projectile):
	behavior.blackboard.set_var("incoming_projectile_var", projectile)

#region serialization
func serialize() -> Dictionary:
	var payload := {
		"health": health.current,
		"mana": mana.current,
		"ability": ability.current,
		"gold": gold,
		"inventory": inventory,
		"spells": spells,
		#"current_uses": {},
		"global_position": [global_position.x, global_position.y]
	}
	# TODO
	#for item_type: ItemBehavior in item_behaviors.get_children():
		#payload["current_uses"][item_type] = item_type.current_cooldown
	return payload

func deserialize(payload: Dictionary):
	for data in payload:
		match data:
			"health":
				health.current = int(payload[data])
			"mana":
				mana.current = int(payload[data])
			"ability":
				ability.current = int(payload[data])
			"gold":
				gold = int(payload[data])
			"inventory":
				inventory = payload[data]
				for item_type in payload[data]:
					inventory_modify(item_type, true)
			"spells":
				spells = payload[data]
				for spell_type in payload[data]:
					inventory_modify(spell_type, true)
			#"current_uses":
				#for item_type in payload[data]:
					#pass # TODO
					#ItemDB.get_item_type_data(item_type).use_enter(payload[data][item_type])
			"global_position":
				global_position.x = payload[data][0]
				global_position.y = payload[data][1]
#endregion
