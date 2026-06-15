@tool
extends BTAction


func _generate_name() -> String:
	return 'Add to inventory | uses: [%s] [%s]' % \
	[
		LimboUtility.decorate_var(LimboVarLib.CHARACTER),
		LimboUtility.decorate_var(LimboVarLib.ITEM_TYPE),
	]


func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	if character.inventory_modify(ItemDB.get_item( \
	blackboard.get_var(LimboVarLib.ITEM_TYPE, Item.Type.INVALID)).type, true):
		return SUCCESS
	return FAILURE
