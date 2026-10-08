@tool
class_name ModifierAmountBase extends Resource

@export var is_percentage: bool
var amount: float: get = get_amount

func _init():
	resource_local_to_scene = true

func get_amount() -> float:
	return amount
