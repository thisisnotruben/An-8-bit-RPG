@tool
class_name Projectile extends Node2D

@onready var fsm: Fsm = $fsm
@onready var timer: Timer = $timer
@onready var dodge_sight: Area2D = $img/dodge_sight
@onready var hit_box: Area2D = $hit_box
@onready var snd: AudioStreamPlayer2D = $snd

@warning_ignore('unused_private_class_variable')
@export_tool_button('Test Projectile', 'Callable') var _test = _test_projectile

@export var game_hit_flags: HitFlags = preload('uid://bdowfnvtuwygf'):
	set(value):
		if not is_node_ready():
			await ready
		game_hit_flags = value
		value.init(self)

@export var strategy: ProjectileStrategy:
	set(value):
		if not is_node_ready():
			await ready
		strategy = value
		if value:
			value.init(self)

var from_character: Character
var direction := Vector2.ZERO
var seek_pos := Vector2.ZERO

signal on_hit(_projectile: Projectile, _character: Character)
signal on_expired(_projectile: Projectile)
signal on_entered(_projectile: Projectile)


func init(_from_character: Character, _direction: Vector2, _seek_pos: Vector2) -> Projectile:
	from_character = _from_character
	direction = _direction
	seek_pos = _seek_pos
	return self

func _ready():
	set_process(false)
	if Engine.is_editor_hint():
		set_physics_process(false)
	else:
		var fsm_args := {}
		for state_node in fsm.get_children():
			fsm_args[state_node.type] = state_node
		fsm.init(fsm_args)

func _physics_process(delta: float):
	fsm.physics_process(delta)

func enter():
	fsm.state = strategy.move_strategy.type
	timer.start()
	on_entered.emit(self)

func exit():
	fsm.state = ProjectileMoveState.Type.STOPPED

func _on_timer_timeout():
	exit()
	on_expired.emit(self)
	queue_free()

func _on_hit_box_body_entered(body: Node2D):
	if from_character.is_foe(body):
		on_hit.emit(self, body)
		(body as Character).health.modify(strategy.damage)
		if not strategy.snd_hit_sfx.is_empty():
			snd.stream = strategy.snd_hit_sfx.pick_random()
			snd.play()

func _on_dodge_sight_body_entered(other_npc: Node2D):
	if from_character.is_foe(other_npc):
		(other_npc as Character).notify_projectile_incoming(self)

## Called by the behavior tree
func play_sound(snd_lib: Array[AudioStream]):
	if not snd_lib.is_empty():
		snd = snd_lib.pick_random()
		snd.play()

#region in editor testing
func _test_projectile():
	set_process(not is_processing())
	$img.rotation = 0.0

func _process(_delta: float):
	$img.look_at(get_global_mouse_position())
#endregion
