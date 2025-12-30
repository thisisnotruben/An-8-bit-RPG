@tool
extends BTAction

@export var attribute: ActionModifyAttribute.TypeAttribute
@export var attack: ModifierAttack


func _generate_name() -> String:
	return "Use attribute: [%s]" % \
		[
			ActionModifyAttribute.TypeAttribute.keys()[attribute],
		]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	var target_stat_component: StatComponent = null
	match attribute:
		ActionModifyAttribute.TypeAttribute.HEALTH:
			target_stat_component = character.health
		ActionModifyAttribute.TypeAttribute.MANA:
			target_stat_component = character.mana
		ActionModifyAttribute.TypeAttribute.ABILITY:
			target_stat_component = character.ability
		_:
			return FAILURE

	target_stat_component.modify(attack)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	match attribute:
		ActionModifyAttribute.TypeAttribute.MOVE_SPEED, \
		ActionModifyAttribute.TypeAttribute.ATTACK_SPEED, \
		ActionModifyAttribute.TypeAttribute.ARMOR:
			warnings.append("Cannot be of attribute [%s]" % \
				ActionModifyAttribute.TypeAttribute.keys()[attribute])
	return warnings
