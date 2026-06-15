@tool
class_name ModifierAmountBase extends Resource

@export var is_percentage: bool
var amount: float: get = get_amount


func get_amount() -> float:
	return amount
