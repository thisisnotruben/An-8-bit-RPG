@tool
extends BTAction


func _generate_name() -> String:
	return "Add to inventory"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if character.inventory_modify(ItemDB.get_item_type_data( \
	blackboard.get_var("item_type_var", Item.Type.INVALID)).type, true):
		return SUCCESS
	return FAILURE
