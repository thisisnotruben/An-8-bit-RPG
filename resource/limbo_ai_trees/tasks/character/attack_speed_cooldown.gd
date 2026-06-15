@tool
extends BTCooldown

func _enter():
	# HACK: have to ref like this because if not then godot throws an error of 'cyclc ref'
	duration = ((blackboard.get_var(LimboVarLib.CHARACTER) as Character) \
		.unit.get('stats') as CharacterStats) \
		.attack_speed_cooldown.current

func _generate_name() -> String:
	return 'Character wait cooldown attack_speed | uses: [%s]' % \
		LimboUtility.decorate_var(LimboVarLib.CHARACTER)
