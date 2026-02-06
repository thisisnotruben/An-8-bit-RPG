@tool
extends BTAction


func _generate_name() -> String:
	return 'Summon terminate'

func _tick(_delta: float) -> Status:
	var target: Node = blackboard.get_var(LimboVarLib.SUMMONED_OBJECT, null)
	if not is_instance_valid(target):
		return FAILURE

	if target is Character:
		target.health.current = 0
	else:
		target.queue_free()
	return SUCCESS
