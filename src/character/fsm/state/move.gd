extends CharacterState
class_name Move

@export var snd_move_audio: Array[AudioStream] = []
@export var snd_move: AudioStreamPlayer2D = null
@export var player_pause := false

@onready var player_move: IState = $player
@onready var npc_move: IState = $npc

@export_range(0.0, 200.0) var speed: float = 16.0
var velocity := Vector2.ZERO: set = _set_velocity, get = _get_velocity


func _ready():
	if snd_move != null:
		snd_move.finished.connect(play_snd_move)

func _init():
	type = CharacterStates.Type.MOVE

func init(args := {}) -> IState:
	super.init(args)
	character.set_player_move_hud_menu_pause.connect(_on_hud_menu_visible)
	return self

func enter():
	super.enter()
	play_snd_move()

func exit():
	super.exit()
	velocity = Vector2.ZERO
	snd_move.stop()

func physics_process(delta: float):
	super.physics_process(delta)
	if character.npc:
		npc_move.physics_process(delta)
	elif not player_pause:
		player_move.physics_process(delta)

# animation
func apply_animation(input_dir: Vector2):
	if input_dir.length() > 0.0:
		var a_t := "parameters/%s/blend_position"
		var anim_direction := input_dir.normalized()
		["attack", "idle", "idle_start", "walk", "hurt"].filter(func(s): \
			return character.anim_tree.get(a_t % s) != null) \
			.map(func(s): character.anim_tree[a_t % s] = anim_direction)

# util
func _set_velocity(_velocity: Vector2):
	character.velocity = _velocity

func _get_velocity() -> Vector2:
	return character.velocity

func play_snd_move():
	if active and not snd_move_audio.is_empty():
		snd_move.stream = snd_move_audio.pick_random()
		snd_move.play()

func _on_hud_menu_visible(is_visible: bool):
	player_pause = is_visible
