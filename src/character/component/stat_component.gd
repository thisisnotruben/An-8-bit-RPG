extends Node
class_name StatComponent

@export var current: int = 1
@export var max_value: int = 1

@export var resistances: Array[ModifierAttack.Type] = []
@export var immunities: Array[ModifierAttack.Type] = []

signal changed(_current: int, _max: int, _old_value: int)


func modify(attack: ModifierAttack):
	if not immunities.has(attack.type):
		var prev_current := current

		if resistances.has(attack.type):
			pass

		var amount: int = abs(attack.amount)
		if not attack.add:
			amount *= -1

		current = clampi(current + amount, 0, max_value)
		if prev_current != current:
			changed.emit(current, max_value, prev_current)
