class_name Move extends CharacterState

@export var snd_move: AudioStreamPlayer2D = null
@export var nav_agent: NavigationAgent2D = null
var next_point := Vector2.ZERO
var direction := Vector2.ZERO
## Used when the player has hud open to pause movement to allow focus controls.
@export var player_pause := false
var speed: float
var velocity: Vector2:
	set(value):
		character.velocity = value
	get:
		return character.velocity


func _init():
	type = CharacterStates.Type.MOVE

func _ready():
	if snd_move:
		snd_move.finished.connect(play_snd_move)

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
	if character.unit.npc:
		npc_move()
	elif not player_pause:
		player_move(delta)

func npc_move():
	if not nav_agent.is_target_reachable() or nav_agent.is_target_reached():
		change_state.emit(CharacterStates.Type.IDLE)
		return

	next_point = nav_agent.get_next_path_position()
	direction = character.global_position.direction_to(next_point)

	if direction:
		velocity = direction * speed

	apply_animation(direction)
	if character.global_position.distance_to( \
	nav_agent.get_final_position()) <= nav_agent.target_desired_distance:
		change_state.emit(CharacterStates.Type.IDLE)

func player_move(delta: float):
	var input_dir := Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	direction = input_dir.normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity = lerp(velocity, direction * speed, delta * 7.0)
	apply_animation(input_dir)
	direction = Vector2.ZERO

func apply_animation(input_dir: Vector2):
	if input_dir.length() > 0.0:
		var a_t := 'parameters/%s/blend_position'
		var anim_direction := input_dir.normalized()
		['attack', 'idle', 'idle_start', 'walk', 'hurt'].filter(func(s): \
			return character.anim_tree.get(a_t % s) != null) \
			.map(func(s): character.anim_tree[a_t % s] = anim_direction)

func play_snd_move():
	if active and not character.unit.snd_move.is_empty():
		snd_move.stream = character.unit.snd_move.pick_random()
		snd_move.play()

func _on_hud_menu_visible(is_visible: bool):
	player_pause = is_visible
