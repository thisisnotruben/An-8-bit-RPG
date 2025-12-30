@tool
extends BTCondition


func _generate_name() -> String:
	return "Ability has cast time?"

func _tick(_delta: float) -> Status:
	var ability: Ability = blackboard.get_var("ability_var")
	if ability and ability.cast_time > 0.0:
		return SUCCESS
	return FAILURE
