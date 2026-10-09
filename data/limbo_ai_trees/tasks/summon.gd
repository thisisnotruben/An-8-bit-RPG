@tool
extends BTAction

@export var strategy: ActionSummon


func _generate_name() -> String:
	var msg := 'Summon: [%s]' % strategy.node_scene.resource_path
	match strategy.pos_type:
		ActionSummon.PosType.SPAWN_POS:
			msg += ' at [%s]' % ActionSummon.PosType.keys()[strategy.pos_type]
	return msg

func _tick(_delta: float) -> Status:
	var character: Node = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	strategy.init(character)
	
	var summoned_object = strategy.node_scene.instantiate()
	character.add_sibling(summoned_object)
	summoned_object.global_position = strategy.pos
	blackboard.set_var(LimboVarLib.SUMMONED_OBJECT, summoned_object)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy == null:
		warnings.append('Need\'s a strategy')
	return warnings
