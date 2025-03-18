extends CharacterState

@export var melee_snd: Array[AudioStream] = []
@export var snd: AudioStreamPlayer2D = null


func _init():
	type = CharacterStates.Type.MELEE

func enter():
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

		change_state.emit(CharacterStates.Type.IDLE)
