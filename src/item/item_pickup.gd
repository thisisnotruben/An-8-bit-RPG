class_name ItemPickup extends Node

@onready var behavior: BTPlayer = $behavior
@export var type := BaseItem.Type.INVALID


func init(_type: BaseItem.Type) -> ItemPickup:
	type = _type
	return self

func _ready():
	behavior.blackboard.set_var(LimboVarLib.ITEM_TYPE, type)
	behavior.blackboard.set_var(LimboVarLib.IS_VITAL, ItemDB.get_item(type) is ItemVital)

func _on_area_body_entered(body: Node2D):
	if body is Character and not body.npc:
		behavior.blackboard.set_var(LimboVarLib.CHARACTER, body)
		behavior.update(0.0)

func _on_area_body_exited(body: Node2D):
	if body is Character and not body.npc:
		behavior.blackboard.set_var(LimboVarLib.CHARACTER, null)
		behavior.update(0.0)

func delete():
	$snd.play()
	await $snd.finished
	queue_free()
