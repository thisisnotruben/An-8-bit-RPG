@tool
extends BTAction

@export var strategy: ActionSummon


func _generate_name() -> String:
	return "Summon: [%s]" % strategy.node_scene.resource_path

func _tick(_delta: float) -> Status:
	var character: Node = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	var summoned_object = strategy.node_scene.instantiate()
	character.add_sibling(summoned_object)
	summoned_object.global_position = strategy.pos
	blackboard.set_save("summoned_object_var", summoned_object)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy == null:
		warnings.append("Need's a strategy.")
	return warnings
