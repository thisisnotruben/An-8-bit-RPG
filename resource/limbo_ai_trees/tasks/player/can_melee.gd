@tool
extends BTCondition


func _generate_name() -> String:
	return "Player can melee?"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if TargetService.can_hit(character):
		return SUCCESS
	return FAILURE
