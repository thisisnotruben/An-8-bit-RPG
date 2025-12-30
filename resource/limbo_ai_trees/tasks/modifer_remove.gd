@tool
extends BTAction

@export var strategy_name_var := ""


func _setup():
	strategy_name_var = strategy_name_var.strip_edges()

func _generate_name() -> String:
	return "Remove Modify attribute [%s]" % strategy_name_var

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	(blackboard.get_var(strategy_name_var) as ActionModifyAttribute) \
		.modify_attribute(character, false)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy_name_var.is_empty():
		warnings.append("Need's a strategy name to act on")
	return warnings
