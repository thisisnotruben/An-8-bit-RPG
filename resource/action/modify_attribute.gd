extends ActionContructor
class_name ActionModifyAttribute

enum TypeModify{ PASSIVE, ACTIVE, }
enum TypeAttribute{ HEALTH, MANA, ABILITY, MOVE_SPEED, ATTACK_SPEED, ARMOR, }

@export var type_modify := TypeModify.PASSIVE
@export var type_attribute := TypeAttribute.HEALTH
@export var modifier: AttackType


func set_attribute(target: Character, invert_modifier: bool):
	var target_stat_component: StatComponent = null
	match type_attribute:
		TypeAttribute.HEALTH:
			target_stat_component = target.health
		TypeAttribute.MANA:
			target_stat_component = target.mana
		TypeAttribute.ABILITY:
			target_stat_component = target.ability
		TypeAttribute.MOVE_SPEED:
			pass # TODO
		TypeAttribute.ATTACK_SPEED:
			pass
		TypeAttribute.ARMOR:
			pass
		_:
			return

	var _modifier := modifier
	if invert_modifier:
		_modifier = _modifier.duplicate()
		_modifier.add = not _modifier.add
		_modifier.amount *= -1

	target_stat_component.max_value += _modifier.amount
	target_stat_component.modify(modifier)
