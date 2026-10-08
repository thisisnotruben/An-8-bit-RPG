@tool
extends BTCondition

@export var state := CharacterStates.Type.IDLE


func _generate_name() -> String:
	return 'Character await state [%s] finished | uses: [%s]' % \
	[
		LimboUtility.decorate_var(CharacterStates.Type.keys()[state]),
		LimboUtility.decorate_var(LimboVarLib.CHARACTER),
	]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	if character.fsm.state == state \
	and character.fsm.get_switch_type() == CharacterState.SwitchType.AT_END:
		match character.fsm.get_switch_status():
			CharacterState.SwitchTypeStatus.ACTIVE:
				return RUNNING
			CharacterState.SwitchTypeStatus.FINISHED:
				return SUCCESS
	return FAILURE
