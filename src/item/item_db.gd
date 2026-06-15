class_name ItemDB extends Node

static var items := { }


static func get_item(item_type: Item.Type) -> BaseItem:
	return items.get(item_type, null)
