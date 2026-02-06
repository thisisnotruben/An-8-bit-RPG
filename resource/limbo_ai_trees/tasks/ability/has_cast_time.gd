@tool
extends BTCondition


func _generate_name() -> String:
	return 'Ability has cast time? | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.ABILITY)

func _tick(_delta: float) -> Status:
	var ability: Ability = blackboard.get_var(LimboVarLib.ABILITY)
	if ability and ability.cast_time > 0.0:
		return SUCCESS
	return FAILURE
