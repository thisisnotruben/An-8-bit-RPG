@tool
extends BTAction

@export var state: CharacterStates.Type


func _generate_name() -> String:
	return "Character set state: [%s]" % CharacterStates.Type.keys()[state]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	character.fsm.state = state
	return SUCCESS
