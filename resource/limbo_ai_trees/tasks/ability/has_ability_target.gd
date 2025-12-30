@tool
extends BTCondition

@export var ability_target_var_name := "ability_target_var"


func _generate_name() -> String:
	return "Character has target for ability"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	var ability: Ability = blackboard.get_var("ability_var")
	if not is_instance_valid(character) or not ability:
		return FAILURE

	var ability_target: Character
	match ability.target_type:
		Ability.TargetType.USER:
			ability_target = character
		Ability.TargetType.TARGET when character.target != null:
			ability_target = character.target
		Ability.TargetType.NONE:
			ability_target = null
		_:
			return FAILURE
	blackboard.set_var(ability_target_var_name, ability_target)
	return SUCCESS
