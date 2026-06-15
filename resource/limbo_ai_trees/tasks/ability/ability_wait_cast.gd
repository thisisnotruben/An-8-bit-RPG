@tool
extends BTWait


func _setup():
	duration = (blackboard.get_var(LimboVarLib.ABILITY) as Ability).cast_time

func _generate_name() -> String:
	return 'Ability wait cast time | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.ABILITY)
