@tool
extends BTCondition


func _generate_name() -> String:
	return 'Character can move to target? | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	character.nav_agent.target_position = character.target.global_position
	if character.nav_agent.is_target_reachable():
		return SUCCESS
	return FAILURE
