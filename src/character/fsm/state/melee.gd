extends CharacterState

@export var melee_snd: Array[AudioStream] = []
@export var snd: AudioStreamPlayer2D = null


func _init():
	type = CharacterStates.Type.MELEE
	switch_type = SwitchType.AT_END

func enter():
	super.enter()
	play_quip()
	switch_type_status = SwitchTypeStatus.ACTIVE
	if active:
		var hit_scan := character.hit_scan_melee.get_collider() as Character
		if character.is_foe(hit_scan):
			hit_scan.health.modify(character.stats.melee_stats.damage)
			if not melee_snd.is_empty():
				snd.stream = melee_snd.pick_random()
				snd.play()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
