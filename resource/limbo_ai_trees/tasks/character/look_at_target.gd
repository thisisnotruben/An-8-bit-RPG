@tool
extends BTAction


func _generate_name() -> String:
	return "Character hit scans look at target"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	character.hit_scan_melee.look_at(character.target.global_position)
	character.hit_scan_shoot.look_at(character.target.global_position)
	return SUCCESS
