class_name ItemService extends Node

static var ITEMS := {}
@export var items: Array[Item] = []


func _ready() -> void:
	items.map(func(i): ITEMS[i.type] = i)

static func get_item(id: Item.Type) -> BaseItem:
	return ITEMS.get(id, null)
