extends BehaviorState

@export var nav_agent: NavigationAgent2D = null
#@export var special_state: Special = null
@export_range(0.0, 1.0, 0.05) var special_chance := 0.5

@onready var melee_timer: Timer = $melee_cooldown
@onready var shoot_timer: Timer = $shoot_cooldown
#@onready var special_timer: Timer = $special_cooldown

var state := -1


func exit():
	super.exit()
	character.target = null

func process(_delta: float):
	if character.target == null \
	or character.target.fsm.state == CharacterStates.Type.DEAD:
		change_state.emit(BehaviorStates.Type.REST)
		return

	state = -1

	# TODO: check if can special
	#if special_state.enabled and special_state.is_valid_state() \
	#and snappedf(randf_range(0.0, 1.0), 0.1) >= special_chance:
		#if is_zero_approx(special_timer.time_left):
			#state = CharacterStates.Type.SPECIAL

	# check if can melee
	if character.fsm.can_melee() \
	and character.hit_scan_melee.get_collider() == character.target:
		if is_zero_approx(melee_timer.time_left):
			state = CharacterStates.Type.MELEE

	# check if can shoot

	elif character.fsm.can_shoot() \
	and character.hit_scan_shoot.get_collider() == character.target:
		if is_zero_approx(shoot_timer.time_left):
			state = CharacterStates.Type.SHOOT

	# otherwise move
	else:
		nav_agent.target_position = character.target.global_position
		if nav_agent.is_target_reachable():
			state = CharacterStates.Type.MOVE
		else:
			change_state.emit(BehaviorStates.Type.REST)

	if state != -1 and character.fsm._set_state(state):
		match state:
			CharacterStates.Type.MELEE:
				melee_timer.start()
			CharacterStates.Type.SHOOT:
				shoot_timer.start()
#			TODO
			#CharacterStates.Type.SPECIAL:
				#special_timer.start()
