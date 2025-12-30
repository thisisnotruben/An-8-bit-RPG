@tool
class_name StatModifer extends Resource

@export var modifiers: Array[ModifierAmountBase] = []
@export var base: ModifierAmountBase
var current := 0.0

signal on_current_changed(_current: float)


func calculate():
	var cum_sum := base.amount
	var cum_product := 1.0
	for modifier in modifiers:
		if modifier.is_percentage:
			cum_product *= modifier.amount
		else:
			cum_sum += modifier.amount

	var new_current := cum_sum * cum_product
	if not is_equal_approx(new_current, current):
		current = new_current
		on_current_changed.emit(new_current)
