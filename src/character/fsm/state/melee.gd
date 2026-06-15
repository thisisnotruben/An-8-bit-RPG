extends CharacterState

@export var snd: AudioStreamPlayer2D = null


func _init():
	type = CharacterStates.Type.MELEE
	switch_type = SwitchType.AT_END

func enter():
	super.enter()
	switch_type_status = SwitchTypeStatus.ACTIVE
	if active:
		var hit_scan := character.hit_scan_melee.get_collider() as Character
		if character.is_foe(hit_scan):

			if blackboard.has(LimboVarLib.ABILITY_PLAYER):
				var ability_player: AbilityPlayer = blackboard.get(LimboVarLib.ABILITY_PLAYER)
				blackboard.erase(LimboVarLib.ABILITY_PLAYER)

				ability_player.blackboard.set_var(LimboVarLib.CHARACTER, hit_scan)
				ability_player.blackboard.set_var(LimboVarLib.ON_HIT, true)
				ability_player.enter()

			hit_scan.health.modify(character.unit.stats.melee.damage)
			if not character.unit.snd_melee.is_empty():
				snd.stream = character.unit.snd_melee.pick_random()
				snd.play()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
