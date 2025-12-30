@tool
extends BTAction


func _generate_name() -> String:
	return "Add vitals to character"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	var item: ItemVital = ItemDB.get_item( \
		blackboard.get_var("item_type_var", BaseItem.Type.INVALID))

	match item.category:
		Item.Category.HEALTH when character.health.current < character.health.max_value:
			character.health.current += int(item.modifier.amount)
		Item.Category.MANA when character.mana.current < character.mana.max_value:
			character.mana.current += int(item.modifier.amount)
		Item.Category.ABILITY when character.ability.current < character.ability.value_max:
			character.ability.current += int(item.modifier.amount)
		_:
			return FAILURE
	return SUCCESS
