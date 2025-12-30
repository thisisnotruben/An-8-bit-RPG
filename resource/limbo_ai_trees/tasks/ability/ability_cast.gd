@tool
extends BTAction

@export var ability_target_var_name := "ability_target_var"


func _generate_name() -> String:
	return "Cast Ability"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	var ability: Ability = blackboard.get_var("ability_var")
	var ability_target: Character = blackboard.get_var(ability_target_var_name)
	if not is_instance_valid(character) or not ability \
	or not is_instance_valid(ability_target):
		return FAILURE

	var ability_player := (preload("uid://c0nmdbo1fso22").instantiate() \
		as AbilityPlayer).init(ability, ability_target)
	character.item_behaviors.add_child(ability_player)

	ability.take_cost(character)
	match ability.target_type:
		Ability.TargetType.USER, Ability.TargetType.NONE:
			ability_player.enter()
		_:
			var state_for_ability := CharacterStates.Type.MELEE
			if ability.projectile_strategy:
				state_for_ability = CharacterStates.Type.SHOOT

			(character.fsm.states[state_for_ability] \
				as CharacterState).blackboard.set("ability_player_var", ability_player)
			character.fsm.state = state_for_ability

	return SUCCESS
