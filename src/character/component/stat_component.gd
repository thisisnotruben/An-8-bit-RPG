class_name StatComponent extends Node

@export var current: int = 1
@export var max_value: int = 1

@export var resistances: Array[ModifierAttack.Type] = []
@export var immunities: Array[ModifierAttack.Type] = []

signal changed(_current: int, _max: int, _old_value: int)

## Amount is not the total amount changed, it's clamped by 0 & 'max_value' 
signal amount_modified(amount: int, aggressor: Character)


func init(_current: int, _max_value: int) -> StatComponent:
	current = _current
	max_value = _max_value
	return self

func modify(attack: ModifierAttack, aggressor: Character = null):
	if not immunities.has(attack.type):
		var prev_current := current

		if resistances.has(attack.type):
			pass # TODO

		var amount: int = abs(attack.modifier.current)
		if not attack.add:
			amount *= -1

		amount_modified.emit(amount, aggressor)
		current = clampi(current + amount, 0, max_value)
		if prev_current != current:
			changed.emit(current, max_value, prev_current)

func reset():
	current = max_value
	
