extends BehaviorState

@export var nav_agent: NavigationAgent2D = null
var move_to_pos := Vector2.ZERO


func enter():
	super.enter()
	if move_to_pos != Vector2.ZERO:
		nav_agent.target_position = move_to_pos
		if nav_agent.is_target_reachable():
			character.fsm.state = CharacterStates.Type.MOVE
		else:
			change_state.emit(BehaviorStates.Type.ATTACK)
