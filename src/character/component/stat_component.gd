extends Node
class_name StatComponent

@export var current: int = 1
@export var max_value: int = 1

@export var resistances: Array[AttackType.Type] = []
@export var immunities: Array[AttackType.Type] = []

signal changed(_current: int, _max: int, _old_value: int)


func modify(modifier: AttackType):
	if not immunities.has(modifier.type):
		var prev_current := current

		if resistances.has(modifier.type):
			pass

		var amount: int = abs(modifier.amount)
		if not modifier.add:
			amount *= -1

		current = clampi(current + amount, 0, max_value)
		if prev_current != current:
			changed.emit(current, max_value, prev_current)
