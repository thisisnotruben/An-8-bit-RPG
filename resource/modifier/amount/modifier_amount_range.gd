@tool
class_name ModifierAmountRange extends ModifierAmountBase

@export var min_amount: float
@export var max_amount: float
@export var cache_amount: bool

var _amount: float
var is_cached: bool


func get_amount() -> float:
	if cache_amount:
		if not is_cached:
			is_cached = true
			_amount = randf_range(min_amount, max_amount)
		return _amount
	return randf_range(min_amount, max_amount)
