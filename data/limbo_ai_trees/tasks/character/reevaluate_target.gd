@tool
extends BTAction


func _generate_name() -> String:
	return 'Character reevaluate target | uses: [%s] [%s]' % \
		[
			LimboUtility.decorate_var(LimboVarLib.CHARACTER),
			LimboUtility.decorate_var(LimboVarLib.IS_RETURN_TO_SPAWN_POS)
		]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE
		
	character.target = character.threat.aggressor_remove(character)
	if not character.target:
		blackboard.set_var(LimboVarLib.IS_RETURN_TO_SPAWN_POS, true)
	return SUCCESS
