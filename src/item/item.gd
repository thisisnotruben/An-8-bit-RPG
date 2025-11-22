extends Node
class_name Item

@export var type := ItemDB.Type.INVALID
var category := ItemDB.Category.NOT_SET
var item_name := ""
var blurb := ""
var icon: Texture = null
var worth: int = 0


func init(args := {}) -> Item:
	var data := ItemDB.get_item_type_data(args["type"])
	type = data.type
	category = data.category
	item_name = data.item_name
	blurb = data.blurb
	icon = data.icon
	worth = data.worth
	return self

func _ready():
	if type != ItemDB.Type.INVALID:
		init({"type": type})

func _on_area_body_entered(body: Node2D):
	if body is Character and not body.npc:
		match category:
			ItemDB.Category.HEALTH:
				if body.health < body.health_max:
					body.health += 1
			ItemDB.Category.MANA:
				if body.mana < body.mana_max:
					body.mana += 1
			ItemDB.Category.ABILITY:
				if body.ability < body.ability_max:
					body.ability += 1
			ItemDB.Category.WEAPON, ItemDB.Category.ARMOR, \
			ItemDB.Category.MISC, ItemDB.Category.KEY:
				if not add_to_inventory(body):
					return
		$snd.play()
		await $snd.finished
		queue_free()

func add_to_inventory(character: Character, add := true) -> bool:
	return character.inventory_add({"type": type, "add": add,
		"spell": category == ItemDB.Category.SPELL})
