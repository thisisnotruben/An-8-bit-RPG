@tool
extends BTAction

@export var strategy: ActionModifyAttribute
@export var add := true


func _generate_name() -> String:
	return "Modify attribute: add [%s], type [%s], amount [%s]" % \
		[add,
		ActionModifyAttribute.TypeAttribute.keys()[strategy.type_attribute],
		strategy.modifier.amount]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	strategy.set_attribute(character, not add)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy == null:
		warnings.append("Need's a strategy.")
	return warnings
