extends Node
class_name ItemDB

enum Category { NOT_SET, HEALTH, MANA, ABILITY, WEAPON, ARMOR, MISC, KEY, SPELL, }
enum Type { INVALID, }
static var items := { }

class ItemData:
	var type := Type.INVALID
	var category := Category.NOT_SET
	var item_name :=  ""
	var blurb :=  ""
	var icon: Texture = null
	var worth: int = 0
	var cooldown: float = 0.0
	var drop := false
	var use := false
	var _use_enter := func(): pass
	var _use_exit := func(): pass

	var user: Character = null


	func use_enter(seek_cooldown := -1.0):
		var timer := user.get_tree().create_timer( \
			cooldown if seek_cooldown < 0.0 else seek_cooldown, false, true)
		user.current_uses[type] = timer
		_use_enter.call()
		await timer.timeout
		user.current_uses.erase(type)

	func use_exit():
		_use_exit.call()


func _ready():
	var item_test := ItemData.new()
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

static func get_item_type_data(item_type: Type) -> ItemData:
	return items.get(item_type, null)
