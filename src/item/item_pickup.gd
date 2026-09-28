class_name ItemPickup extends Node

@onready var behavior: BTPlayer = $behavior
@onready var snd: AudioStreamPlayer = $snd
@onready var img: Sprite2D = $img

@export var type := BaseItem.Type.INVALID


func init(item_id: BaseItem.Type) -> ItemPickup:
	type = item_id
	return self

func _ready():
	behavior.blackboard.set_var(LimboVarLib.ITEM_TYPE, type)
	behavior.blackboard.set_var(LimboVarLib.IS_VITAL, ItemService.get_item(type) is ItemVital)
	if type != Item.Type.INVALID:
		# NOTICE: img accommodates a 8x8 texture
		img.texture = ItemService.get_item(type).icon

func _on_area_body_entered(body: Node2D):
	if body is Character and not body.unit.npc:
		behavior.blackboard.set_var(LimboVarLib.CHARACTER, body)
		behavior.update(0.0)

func _on_area_body_exited(body: Node2D):
	if body is Character and not body.unit.npc:
		behavior.blackboard.set_var(LimboVarLib.CHARACTER, null)
		behavior.update(0.0)

func delete():
	snd.play()
	if snd.stream:
		await snd.finished
	queue_free()
	
func collect():
	var tween := get_tree().create_tween() \
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(img, 'position', Vector2(0.0, -6.0), 1.0)
	await tween.finished
	delete()
