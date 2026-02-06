@tool
extends BTCooldown


func _enter() -> void:
	duration = 1.5#(blackboard.get_var(LimboVarLib.CHARACTER) as Character) \
		#.unit.stats.attack_speed_cooldown.current
		# TODO
func _generate_name() -> String:
	return 'Character wait cooldown attack_speed | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)
