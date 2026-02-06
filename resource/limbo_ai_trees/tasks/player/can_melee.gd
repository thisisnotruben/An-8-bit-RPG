@tool
extends BTCondition


func _generate_name() -> String:
	return 'Player can melee? | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	if TargetService.can_hit(character):
		return SUCCESS
	return FAILURE
