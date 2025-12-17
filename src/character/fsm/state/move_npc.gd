extends IState

@onready var move: Move = get_parent()
@export var nav_agent: NavigationAgent2D = null

var next_point := Vector2.ZERO
var direction := Vector2.ZERO


func _ready():
	if nav_agent:
		nav_agent.max_speed = move.speed

func physics_process(_delta: float):
	if not nav_agent.is_target_reachable() or nav_agent.is_target_reached():
		move.change_state.emit(CharacterStates.Type.IDLE)
		return

	next_point = nav_agent.get_next_path_position()
	direction = move.character.global_position.direction_to(next_point)

	if direction:
		move.velocity = direction * move.speed

	move.apply_animation(direction)
	if move.character.global_position.distance_to( \
	nav_agent.get_final_position()) <= nav_agent.target_desired_distance:
		change_state.emit(CharacterStates.Type.IDLE)
