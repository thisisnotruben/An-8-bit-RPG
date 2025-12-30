@tool
extends BTCondition

@export var distance_threshold: float


func _generate_name() -> String:
	return "Character has arrived?"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if character.global_position.distance_to(character.global_position) > distance_threshold:
		return RUNNING
	return SUCCESS
