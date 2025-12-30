@tool
extends BTCooldown

@export var item_type: BaseItem.Type


func _setup():
	duration = ItemDB.get_item(item_type).cooldown

func _generate_name() -> String:
	return "Item Cooldown [%s]" % BaseItem.Type.keys()[item_type]

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if item_type == BaseItem.Type.INVALID:
		warnings.append("[item_type] cannot be [INVALID].")
	return warnings
