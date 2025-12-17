@tool
extends BTAction

@export var strategy: ActionResistance
@export var add := true


func _generate_name() -> String:
	return "Resistance: add [%s], resistance type [%s], amount [%s]" % \
		[add, AttackType.Type.keys()[strategy.resistance.type], strategy.resistance.amount]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if add:
		character.health.resistances.append(strategy)
	else:
		character.health.resistances.erase(strategy)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy == null:
		warnings.append("Need's a strategy.")
	return warnings
