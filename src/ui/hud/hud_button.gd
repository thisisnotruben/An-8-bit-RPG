extends Button
class_name HudButton

@export var item_icon: Texture = null: set = _on_set_icon
var item: Item = null: set = _on_set_item


func _on_set_item(value: Item):
	item = value
	_on_set_icon(value.icon)

func _on_set_icon(value: Texture):
	$icon.texture = value

func _on_focus_entered():
	$anim.play("focus")

func _on_focus_exited():
	$anim.play("unfocus")
