@tool
extends BTWait

@export var item_type: BaseItem.Type


func _setup():
	duration = ItemDB.get_item(item_type).cooldown

func _generate_name() -> String:
	return "Wait cooldown item: [%s]" % BaseItem.Type.keys()[item_type]

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if item_type == BaseItem.Type.INVALID:
		warnings.append("Type cannot be [INVALID].")
	return warnings
