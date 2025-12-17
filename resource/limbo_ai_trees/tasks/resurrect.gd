@tool
extends BTAction

@export var strategy: ActionResurrection


func _generate_name() -> String:
	return "Resurrect to health pct: [%s]" % str(strategy.resurrect_pct_health)

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	if character.fsm.state != CharacterStates.Type.DEAD:
		character.health.current = floori(character.health.max_value * strategy.resurrect_pct_health)
		return SUCCESS
	return FAILURE

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy == null:
		warnings.append("Need's a strategy.")
	return warnings
