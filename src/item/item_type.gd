extends Node
class_name ItemDB

enum Category { NOT_SET, HEALTH, MANA, ABILITY, WEAPON, ARMOR, MISC, KEY, SPELL, }
enum Type { INVALID, }
static var items := { }

class item_packet:
	var type := Type.INVALID
	var category := Category.NOT_SET
	var item_name :=  ""
	var blurb :=  ""
	var icon: Texture = null
	var worth: int = 0
	var cooldown: int = 0
	var drop := false
	var use := false
	var _use_enter := func(): pass
	var _use_exit := func(): pass

	func use_enter():
		_use_enter.call()

	func use_exit():
		_use_exit.call()


func _ready():
	var item_test := item_packet.new()
	item_test.Type = Type.INVALID
	item_test.category = Category.WEAPON
	item_test.item_name = "Foo Bar"
	item_test.blurb = "Loren Ipsum"
	item_test.icon = null
	item_test.worth = 0
	item_test.drop = false
	item_test.use = true
	item_test._use_enter = func(): print("use enter")
	item_test._use_exit = func(): print("use exit")

	var master_list := [item_test, ]
	for item in master_list:
		items.set(item.Type, item)

static func get_item_type_data(item_type: Type) -> item_packet:
	return items[item_type]
