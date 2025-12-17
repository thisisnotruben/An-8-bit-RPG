@tool
extends BTAction


func _generate_name() -> String:
	return "Add vitals to character"

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	var item: ItemVital = ItemDB.get_item_type_data( \
		blackboard.get_var("item_type_var", BaseItem.Type.INVALID))

	match item.category:
		Item.Category.HEALTH when character.health.current < character.health.max_value:
			character.health.current += item.amount
		Item.Category.MANA when character.mana.current < character.mana.max_value:
			character.mana.current += item.amount
		Item.Category.ABILITY when character.ability.current < character.ability.value_max:
			character.ability.current += item.amount
		_:
			return FAILURE
	return SUCCESS
