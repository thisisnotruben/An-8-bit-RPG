@tool
extends BTCondition


func _generate_name() -> String:
	return 'Character can roam? | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE
		
	return FAILURE if character.unit.roam.type == IdleRoam.Type.NONE else SUCCESS
