@tool
extends BTAction

@export var strategy: ActionImmunity
@export var add := true


func _generate_name() -> String:
	return "Immunity: add [%s], type [%s]" % \
		[add, ModifierAttack.Type.keys()[strategy.immunity]]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if add:
		character.health.immunities.append(strategy)
	else:
		character.health.immunities.erase(strategy)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy == null:
		warnings.append("Need's a strategy.")
	elif strategy.immunity == ModifierAttack.Type.NORMAL:
		warnings.append("Strategy immunity cannot be of type: [NORMAL].")
	return warnings
