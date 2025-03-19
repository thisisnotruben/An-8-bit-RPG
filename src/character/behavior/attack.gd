extends BehaviorState

@onready var melee_timer: Timer = $melee_cooldown
@onready var shoot_timer: Timer = $shoot_cooldown

@export var nav_agent: NavigationAgent2D = null
var melee_cooldown := false
var shoot_cooldown := false
var spell_call := []
var state := -1


func exit():
	super.exit()
	character.target = null

func process(_delta: float):
	if character.target == null \
	or character.target.fsm.state == CharacterStates.Type.DEAD:
		change_state.emit(BehaviorStates.Type.REST)
		return

	character.hit_scan_melee.look_at(character.target.global_position)
	character.hit_scan_shoot.look_at(character.target.global_position)
	state = -1
	spell_call = can_cast_spell()

	# check if can cast spell
	if spell_call[0]:
		state = spell_call[1]

	# check if can melee
	elif character.fsm.can_melee() \
	and character.hit_scan_melee.get_collider() == character.target:
		if not melee_cooldown:
			state = CharacterStates.Type.MELEE

	# check if can shoot

	elif character.fsm.can_shoot() \
	and character.hit_scan_shoot.get_collider() == character.target:
		if not shoot_cooldown:
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
				melee_cooldown = true
				melee_timer.start()
			CharacterStates.Type.SHOOT:
				shoot_cooldown = true
				shoot_timer.start()

func _on_melee_cooldown_timeout():
	melee_cooldown = false

func _on_shoot_cooldown_timeout():
	shoot_cooldown = false

func can_cast_spell() -> Array:
#	polymorphous method meant to be overridden
	return [false, -1]
