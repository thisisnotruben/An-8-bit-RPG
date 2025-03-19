extends Node
class_name Item

enum Type {
	HEALTH,
	FORTIFY,
	KEY,
	WEAPON,
	ARMOR,
}

@export var type := -1
@export var icon: Texture = null


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
