extends CharacterState

@export var melee_snd: Array[AudioStream] = []
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

			if blackboard.has('ability_player_var'):
				var ability_player: AbilityPlayer = blackboard.get('ability_player_var')
				blackboard.erase('ability_player_var')

				ability_player.blackboard.set_var('character_var', hit_scan)
				ability_player.blackboard.set_var('on_hit_var', true)
				ability_player.enter()

			hit_scan.health.modify(character.unit.stats.melee.damage)
			if not melee_snd.is_empty():
				snd.stream = melee_snd.pick_random()
				snd.play()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
