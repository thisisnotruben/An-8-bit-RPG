@tool
extends BTAction

@export var ability_target_var_name := LimboVarLib.ABILITY_TARGET


func _generate_name() -> String:
	return 'Cast Ability | uses: [%s] [%s] [%s]' % \
	[
		LimboUtility.decorate_var(ability_target_var_name),
		LimboUtility.decorate_var(LimboVarLib.CHARACTER),
		LimboUtility.decorate_var(LimboVarLib.ABILITY),
	]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	var ability: Ability = blackboard.get_var(LimboVarLib.ABILITY)
	var ability_target: Character = blackboard.get_var(ability_target_var_name)
	if not is_instance_valid(character) or not ability \
	or not is_instance_valid(ability_target):
		return FAILURE

	character.spawn_ability_player(ability, ability_target)
	return SUCCESS
