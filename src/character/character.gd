extends CharacterBody2D
class_name Character

enum CharaterSideRoles { MERCHANT, TRAINER, DIALOGUE, }
const WORLD_LAYER := 0b00000000_00000000_00000000_00000001

@onready var fsm: Fsm = $fsm
@onready var behavior: Fsm = $fsm_behavior.init({
	BehaviorStates.Type.REST: $fsm_behavior/rest,
	BehaviorStates.Type.ATTACK: $fsm_behavior/attack,
	BehaviorStates.Type.MOVE_TO: $fsm_behavior/move_to}
	, {"character": self})
@onready var anim: AnimationPlayer = $anim_player
@onready var anim_tree: AnimationTree = $anim_tree
@onready var img: Sprite2D = $img
@onready var body: CollisionShape2D = $body
@onready var snd: AudioStreamPlayer2D = $snd
@onready var snd_shoot: AudioStreamPlayer2D = $snd_shoot
@onready var snd_melee: AudioStreamPlayer2D = $snd_melee
@onready var hit_scan_shoot: RayCast2D = $hit_shoot_cast
@onready var hit_scan_melee: RayCast2D = $hit_melee_cast
@onready var health_regen_timer: Timer = $health_regen
@onready var mana_regen_timer: Timer = $mana_regen
@onready var ability_regen_timer: Timer = $ability_regen

@export_category("Descriptors")
@export var character_name := ""
@export var character_roles: Array[CharaterSideRoles] = []
@export var npc = true: set = _set_npc
@export var friendly := false: set = _set_friendly
@export_subgroup("Hit Flags")
@export_flags_3d_physics var character_hit_flag := 0b00000000_00000000_00000000_00000010
@export_flags_3d_physics var friendly_hit_flag := 0b00000000_00000000_00000000_00000100
@export_flags_3d_physics var foe_hit_flag := 0b00000000_00000000_00000000_00001000
@export_flags_3d_physics var player_hit_flag := 0b00000000_00000000_00000000_00010000

@export_category("Vitals")
@export_subgroup("health")
@export_range(1, 10) var health_max: int = 2
var health: int : set = _set_health
@export_range(1.0, 90.0, 0.1) var health_regen_sec: float = 30.0: set = _set_health_regen
@export_range(1, 10) var health_regen: int = 1
@export_subgroup("mana")
@export_range(1, 10) var mana_max: int = 2
var mana: int : set = _set_mana
@export_range(1.0, 90.0, 0.1) var mana_regen_sec: float = 30.0: set = _set_mana_regen
@export_range(1, 10) var mana_regen: int = 1
@export_subgroup("ability")
@export_range(1, 10) var ability_max: int = 2
var ability: int : set = _set_ability
@export_range(1.0, 90.0, 0.1) var ability_regen_sec: float = 30.0: set = _set_ability_regen
@export_range(1, 10) var ability_regen: int = 1

@export_category("Combat Stats")
@export_subgroup("Melee")
@export_range(1, 10) var melee_damage: int = 1
@export_range(0.0, 64.0) var melee_range: float = 1.1
@export_subgroup("Shoot")
@export_range(1, 10) var shoot_damage: int = 1
@export_range(0.0, 64.0) var shoot_range: float = 12.0

@export_category("Items")
@export var inventory: Array[ItemDB.Type] = []
@export var spells: Array[ItemDB.Type] = []
# int [0 - 100 range] (drop percent)
@export var drops: Dictionary[int, ItemDB.Type] = {}
var current_uses: Dictionary[ItemDB.Type, SceneTreeTimer] = {}

@export_category("Optional Misc")
@export var target: Character = null

signal health_changed(_health, _max_health)
signal mana_changed(_mana, _max_mana)
signal ability_changed(_ability, _max_ability)
signal died(_character)

signal inventory_added(_item)
signal spell_added(_spell)
var is_inventory_full := func(): return true
var is_spellbook_full := func(): return true

signal set_player_move_hud_menu_pause(is_hud_panel_visible)


func _ready():
	var fsm_init := {}
	$fsm.get_children() \
		.filter(func(s): return s is CharacterState and s.enabled) \
		.map(func(s): fsm_init[s.type] = s)
	$fsm.init(fsm_init, {"character": self})
	behavior.state = BehaviorStates.Type.REST
	health = health_max
	_set_npc(npc)

func _on_nav_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity

func _physics_process(delta: float):
	if npc:
		behavior.physics_process(delta)
	fsm.physics_process(delta)
	move_and_slide()

func _process(delta: float):
	if npc:
		behavior.process(delta)
	else:
		_handle_input()
	fsm.process(delta)

func _input(event: InputEvent):
	fsm.input(event)

func _set_health_regen(value: float):
	$health_regen.wait_time = value
	$health_regen.start()

func _set_mana_regen(value: float):
	$mana_regen.wait_time = value
	$mana_regen.start()

func _set_ability_regen(value: float):
	$ability_regen.wait_time = value
	$ability_regen.start()

func _on_health_regen_timeout():
	_set_health(health_regen)

func _on_mana_regen_timeout():
	_set_mana(mana_regen)

func _on_ability_regen_timeout():
	_set_ability(ability_regen)

func _set_health(_health: int):
	var prev_health := health
	health = clampi(_health, 0, health_max)
	var connected_joy := not npc and Input.is_joy_known(0)
	if health >= 0 and fsm.state != CharacterStates.Type.DEAD:
		health_changed.emit(health, health_max)
	if health == 0:
		fsm.state = CharacterStates.Type.DEAD
		health_regen_timer.stop()
		mana_regen_timer.stop()
		ability_regen_timer.stop()
		died.emit(self)
		if connected_joy:
			Input.start_joy_vibration(0, 0.0, 1.0, 1.0)
	elif prev_health > health:
		fsm.state = CharacterStates.Type.HURT
		if connected_joy:
			Input.start_joy_vibration(0, 1.0, 0.0, 0.5)

func _set_mana(_mana: int):
	var prev_mana := mana
	mana = clampi(_mana, 0, mana_max)
	if prev_mana != mana:
		mana_changed.emit(mana, mana_max)

func _set_ability(_ability: int):
	var prev_ability := ability
	ability = clampi(_ability, 0, ability_max)
	if prev_ability != ability:
		ability_changed.emit(ability, mana_max)

func set_hit_flags():
	var hit_layer := character_hit_flag
	hit_layer += friendly_hit_flag if friendly else foe_hit_flag
	if not npc:
		hit_layer += player_hit_flag
	set_deferred("collision_layer", hit_layer)

	var hit_scan := WORLD_LAYER
	hit_scan += foe_hit_flag if friendly else friendly_hit_flag
	if not friendly:
		hit_scan += player_hit_flag

	$hit_melee_cast.set_deferred("collision_mask", hit_scan)
	$hit_melee_cast.set_deferred("target_position.x", melee_range)

	$hit_shoot_cast.set_deferred("collision_mask", hit_scan)
	$hit_shoot_cast.set_deferred("target_position.x", shoot_range)

func _set_npc(_npc: bool):
	npc = _npc
	add_to_group("npc" if _npc else "player")
	$nav_agent.avoidance_enabled = _npc
	$cam.enabled = not _npc
	_set_friendly(friendly)

func _set_friendly(_friendly: bool):
	friendly = _friendly
	set_hit_flags.call_deferred()
	if npc:
		if _friendly:
			remove_from_group("foe")
			add_to_group("friendly")
		else:
			remove_from_group("friendly")
			add_to_group("foe")
	else:
		add_to_group("friendly")

func inventory_add(data: Dictionary) -> bool:
	if data["add"]:
		if data["spell"]:
			if not is_spellbook_full.call():
				spells.append(data)
				spell_added.emit(data)
				return true
		elif not is_inventory_full.call():
			inventory.append(data)
			inventory_added.emit(data)
			return true
		return false
	else:
		if data["spell"]:
			if spells.has(data["type"]):
				spells.erase(data["type"])
				spell_added.emit(data)
		elif inventory.has(data["type"]):
			inventory.erase(data["type"])
			inventory_added.emit(data)
		return true

func is_foe(_body: Node2D) -> bool:
	return _body is Character and _body.fsm.state != CharacterStates.Type.DEAD \
	and (_body.friendly != friendly or (not _body.npc and not friendly))

# player behavior

func _handle_input():
	var state := CharacterStates.Type.IDLE
	if Input.get_vector("move_left", "move_right",
	"move_up", "move_down").length() > 0.0:
		state = CharacterStates.Type.MOVE
	elif Input.is_action_just_pressed("attack"):
		if fsm.can_melee():
			state = CharacterStates.Type.MELEE
		elif fsm.can_shoot():
			state = CharacterStates.Type.SHOOT
	fsm.state = state

# npc behavior

func _on_sight_body_entered(_body: Node2D):
	if not aggro(_body) \
	and behavior.state == BehaviorStates.Type.ATTACK \
	and _body.target == null:
		_body.aggro(target)

func _on_sight_area_entered(area: Node3D):
	if npc and target == null and area.owner is Bullet \
	and area.owner.from_character != null:
		aggro(area.owner.from_character)

func aggro(_body: Node2D) -> bool:
	if npc and is_foe(_body):
		target = _body
		behavior.state = BehaviorStates.Type.ATTACK
		$sight.get_overlapping_bodies() \
			.filter(func(b): return \
				b != self and not is_foe(b) and b.target == null) \
			.map(func(c): c.aggro(target))
		return true
	return false

func move_to(pos: Vector3):
	behavior.get_node("move_to").move_to_pos = pos
	behavior.state = BehaviorStates.Type.MOVE_TO
