@tool
extends BTWait


func _setup():
	duration = (blackboard.get_var("ability_var") as Ability).cast_time

func _generate_name() -> String:
	return "Ability wait cast time"
