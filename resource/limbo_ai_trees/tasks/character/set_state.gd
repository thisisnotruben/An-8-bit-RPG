@tool
extends BTAction

@export var state: CharacterStates.Type


func _generate_name() -> String:
	return 'Character set state [%s] | uses: [%s]' % \
	[
		LimboUtility.decorate_var(CharacterStates.Type.keys()[state]),
		LimboUtility.decorate_var(LimboVarLib.CHARACTER),
	]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	character.fsm.state = state
	return SUCCESS
