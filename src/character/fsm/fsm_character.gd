extends Fsm
class_name FsmCharacter

var anim_state_map := {}
@export var character: Character = null


func init(_states := {}, _state_args := {}) -> Fsm:
	var init_args := {}
	for _state_type in _states:
		init_args[_state_type] = _states[_state_type][0]
		anim_state_map[_state_type] = _states[_state_type][1]
	super.init(init_args, _state_args)
	return self

func can_melee() -> bool:
	return states.has(CharacterStates.Type.MELEE)

func can_shoot() -> bool:
	return states.has(CharacterStates.Type.SHOOT)
