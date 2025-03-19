extends CharacterState
class_name Move

@onready var player_move: IState = $player
@onready var npc_move: IState = $npc

@export_range(0.0, 20.0) var speed: float = 16.0
var velocity := Vector2.ZERO: set = _set_velocity, get = _get_velocity


func _init():
	type = CharacterStates.Type.MOVE

func exit():
	super.exit()
	velocity = Vector2.ZERO

func physics_process(delta: float):
	super.physics_process(delta)
	if character.npc:
		npc_move.physics_process(delta)
	else:
		player_move.physics_process(delta)

# animation
func apply_animation(input_dir: Vector2):
	if input_dir.length() > 0.0:
		var a_t := "parameters/%s/blend_position"
		var anim_direction := input_dir.normalized()
		["attack", "idle", "idle_start", "move", "hurt"].filter(func(s): \
			return character.anim_tree.get(a_t % s) != null) \
			.map(func(s): character.anim_tree[a_t % s] = anim_direction)

# util
func _set_velocity(_velocity: Vector2):
	character.velocity = _velocity

func _get_velocity() -> Vector2:
	return character.velocity
