extends Node
class_name Item

enum Type {
	NOT_SET,
	HEALTH,
	FORTIFY,
	KEY,
	WEAPON,
	ARMOR,
}

@export var type := Type.NOT_SET
@export var item_name := ""
@export var blurb := ""
@export var icon: Texture = null
@export var worth: int = 0


func _on_area_body_entered(body: Node2D):
	if body is Character and not body.npc:
		match type:
			Type.HEALTH:
				if body.health == body.health_max:
					return
				body.health += 1
			Type.FORTIFY:
				pass
			_:
				add_to_inventory(body)
		$snd.play()
		await $snd.finished
		queue_free()

func add_to_inventory(character: Character, add := true, powerup: Item = null):
	character.inventory_add({"type": type, "icon": icon, \
		"add": add, "powerup": powerup, "character": character})
