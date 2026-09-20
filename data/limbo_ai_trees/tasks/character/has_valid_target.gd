@tool
extends BTCondition


func _generate_name() -> String:
	return 'Has valid target? | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	if character.is_foe(character.target):
		return SUCCESS
	return FAILURE
