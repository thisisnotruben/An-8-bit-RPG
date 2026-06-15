@tool
extends BTAction


func _generate_name() -> String:
	return 'Character hit scans look at target | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	character.hit_scan_melee.look_at(character.target.global_position)
	character.hit_scan_shoot.look_at(character.target.global_position)
	return SUCCESS
