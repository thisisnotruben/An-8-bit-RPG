extends CharacterState

@export var melee_snd: Array[AudioStream] = []
@export var snd: AudioStreamPlayer2D = null


func _init():
	type = CharacterStates.Type.MELEE
	switch_type = SwitchType.AT_END

func enter():
	switch_type_status = SwitchTypeStatus.ACTIVE
	super.enter()
	play_quip()
	await get_tree().create_timer(0.5).timeout
	if active:
		var hit_scan := character.hit_scan_melee.get_collider()
		if character.is_foe(hit_scan):
			hit_scan.health -= character.melee_damage
			if not melee_snd.is_empty():
				snd.stream = melee_snd.pick_random()
				snd.play()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
		change_state.emit(CharacterStates.Type.IDLE)
