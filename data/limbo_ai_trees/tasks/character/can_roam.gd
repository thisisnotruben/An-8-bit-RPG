@tool
extends BTCondition


func _generate_name() -> String:
	return 'Character can roam? | uses: [%s] [%s]' % \
		[
			LimboUtility.decorate_var(LimboVarLib.CHARACTER),
			LimboUtility.decorate_var(LimboVarLib.HAS_THREATS)
		]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE
		
	return \
		SUCCESS if character.unit.roam.type != IdleRoam.Type.NONE \
			and not blackboard.get_var(LimboVarLib.HAS_THREATS, false) \
	else \
		FAILURE
