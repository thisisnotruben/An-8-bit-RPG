@tool
extends BTCondition

@export var item_type := BaseItem.Type.INVALID


func _generate_name() -> String:
	return "Character has item: [%s]" % BaseItem.Type.keys()[item_type]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if character.inventory.has(item_type):
		return SUCCESS
	return FAILURE
