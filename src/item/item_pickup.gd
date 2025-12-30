class_name ItemPickup extends Node

@onready var behavior: BTPlayer = $behavior
@export var type := BaseItem.Type.INVALID


func init(_type: BaseItem.Type) -> ItemPickup:
	type = _type
	return self

func _ready():
	behavior.blackboard.set_var('item_type_var', type)
	behavior.blackboard.set_var('is_vital_pickup_var', ItemDB.get_item(type) is ItemVital)

func _on_area_body_entered(body: Node2D):
	if body is Character and not body.npc:
		behavior.blackboard.set_var('character_var', body)
		behavior.update(0.0)

func _on_area_body_exited(body: Node2D):
	if body is Character and not body.npc:
		behavior.blackboard.set_var('character_var', null)
		behavior.update(0.0)

func delete():
	$snd.play()
	await $snd.finished
	queue_free()
