extends ActionContructor
class_name ActionModifyAttribute

enum TypeAttribute{ HEALTH, MANA, ABILITY, MOVE_SPEED, ATTACK_SPEED, ARMOR, }

@export var type_attribute := TypeAttribute.HEALTH
@export var modifier: ModifierAmountBase


func modify_attribute(target: Character, add: bool):
	var target_stat_component: StatComponent = null
	match type_attribute:
		TypeAttribute.HEALTH:
			target_stat_component = target.health
		TypeAttribute.MANA:
			target_stat_component = target.mana
		TypeAttribute.ABILITY:
			target_stat_component = target.ability

		TypeAttribute.ATTACK_SPEED, TypeAttribute.MOVE_SPEED:
			var mod_arr := []
			match type_attribute:
				TypeAttribute.ATTACK_SPEED:
					mod_arr = target.unit.attack_speed_modifiers
				TypeAttribute.MOVE_SPEED:
					mod_arr = target.unit.speed_modifiers
				_:
					return

			if add:
				mod_arr.append(modifier)
			else:
				mod_arr.erase(modifier)
			target.unit.recalculate(mod_arr)

		TypeAttribute.ARMOR:
			pass

	if target_stat_component:
		var _modifier := modifier
		if add:
			_modifier = _modifier.duplicate()
			_modifier.add = not _modifier.add
			_modifier.amount *= -1

		target_stat_component.max_value += int(_modifier.amount)
		#target_stat_component.modify(modifier)
