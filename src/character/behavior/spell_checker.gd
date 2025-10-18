extends Node
class_name SpellChecker


func can_cast_spell() -> Array:
#	polymorphous method meant to be overridden
	return [false, -1]
