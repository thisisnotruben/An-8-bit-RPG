@tool
extends BTCondition

@export var in_pursuit := false


func _generate_name() -> String:
	return 'Character can melee? | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE
		
	if in_pursuit and not character.unit.pursuit_can_melee_check:
		return SUCCESS # bypasses check

	return SUCCESS if character.fsm.can_melee() \
		and character.hit_scan_melee.get_collider() == character.target \
	else FAILURE
