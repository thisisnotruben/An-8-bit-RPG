extends Node
class_name ItemDB

static var items := { }


static func get_item_type_data(item_type: Item.Type) -> BaseItem:
	return items.get(item_type, null)
