@tool
extends BTAction

@export var audio_lib_type: CharacterStates.Type


func _generate_name() -> String:
	return "Character play random audio from library: [%s]" % \
		CharacterStates.Type.keys()[audio_lib_type]

func _tick(_delta: float) -> Status:
	var character: Character = blackboard.get_var("character_var")
	if not is_instance_valid(character):
		return FAILURE

	var audio_lib := []
	match audio_lib_type:
		CharacterStates.Type.IDLE:
			audio_lib = character.unit.snd_idle
		CharacterStates.Type.MOVE:
			audio_lib = character.unit.snd_move
		CharacterStates.Type.DEAD:
			audio_lib = character.unit.snd_dead
		CharacterStates.Type.MELEE:
			audio_lib = character.unit.snd_melee
		CharacterStates.Type.SHOOT:
			audio_lib = character.unit.snd_shoot
		CharacterStates.Type.HURT:
			audio_lib = character.unit.snd_hurt
		_:
			return FAILURE

	if not audio_lib.is_empty():
		character.snd = audio_lib.pick_random()
		character.snd.play()
	return SUCCESS
