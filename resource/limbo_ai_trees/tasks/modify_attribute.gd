@tool
extends BTAction

@export var strategy: ActionModifyAttribute
@export var strategy_var_name := ''


func _setup():
	strategy_var_name = strategy_var_name.strip_edges()
	blackboard.set_var(strategy_var_name, strategy)

func _generate_name() -> String:
	var display_string := 'Modify attribute'
	if strategy and strategy.modifier:
		display_string = 'Modify attribute type [%s], amount [%s%s] [%s]' % \
			[
				LimboUtility.decorate_var(ActionModifyAttribute.TypeAttribute.keys()[strategy.type_attribute]),
				strategy.modifier.amount,
				'%' if strategy.modifier.is_percentage else '',
				LimboUtility.decorate_output_var(strategy_var_name),
			]
	return display_string

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE

	strategy.modify_attribute(character, true)
	return SUCCESS

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	if strategy == null:
		warnings.append('Need\'s a strategy')
	return warnings
