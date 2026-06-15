@tool
extends BTCondition

@export var ability_target_var_name := LimboVarLib.ABILITY_TARGET


func _generate_name() -> String:
	return 'Character has target for ability [%s] | uses: [%s] [%s]' % \
	[
		LimboUtility.decorate_output_var(ability_target_var_name),
		LimboUtility.decorate_var(LimboVarLib.CHARACTER),
		LimboUtility.decorate_var(LimboVarLib.ABILITY),
	]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	var ability: Ability = blackboard.get_var(LimboVarLib.ABILITY)
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
