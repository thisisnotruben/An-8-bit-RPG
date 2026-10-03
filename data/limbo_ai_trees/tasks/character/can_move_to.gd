@tool
extends BTCondition

@export var pos_type := LimboVarLib.PosType.TARGET


func _generate_name() -> String:
	var text := 'Character can move to [%s]? | uses: [%s]' % \
		[
			LimboUtility.decorate_var(LimboVarLib.PosType.keys()[pos_type]),
			LimboUtility.decorate_var(LimboVarLib.CHARACTER)
		]
		
	if pos_type == LimboVarLib.PosType.ROAM:
		text += ' [%s]' % LimboUtility.decorate_var(LimboVarLib.HAS_ROAM_MOVED_VAR)
	return text

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var(LimboVarLib.CHARACTER)
	if not is_instance_valid(character):
		return FAILURE
		
	var pos := Vector2.ZERO
	match pos_type:
		LimboVarLib.PosType.TARGET when character.target:
			pos = character.target.global_position
		LimboVarLib.PosType.ROAM_LAST_POS:
			pos = character.unit.roam.recent_pos
		LimboVarLib.PosType.ROAM:
			if blackboard.get_var(LimboVarLib.HAS_ROAM_MOVED_VAR, false):
				return SUCCESS
			pos = character.unit.roam.get_pos()
			
	if pos.is_zero_approx():
		return FAILURE
		
	character.nav_agent.target_position = pos
	if character.nav_agent.is_target_reachable():
		if pos_type == LimboVarLib.PosType.ROAM:
			blackboard.set_var(LimboVarLib.HAS_ROAM_MOVED_VAR, true)
			
		return SUCCESS
	return FAILURE
