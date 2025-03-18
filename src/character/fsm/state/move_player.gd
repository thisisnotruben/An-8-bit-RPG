extends IState

@onready var move: Move = get_parent()


func physics_process(delta: float):
	var input_dir := Input.get_vector("move_left", "move_right",
		"move_up", "move_down")
	var direction := input_dir.normalized()

	if direction:
		move.velocity = direction * move.speed
	else:
		move.velocity = lerp(move.velocity, direction * move.speed, delta * 7.0)

	move.apply_animation(input_dir)
