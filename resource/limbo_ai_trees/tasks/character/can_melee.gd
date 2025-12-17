@tool
extends BTCondition


func _generate_name() -> String:
	return "Character can melee?"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if character.fsm.can_melee() \
	and character.hit_scan_melee.get_collider() == character.target:
		return SUCCESS
	return FAILURE
