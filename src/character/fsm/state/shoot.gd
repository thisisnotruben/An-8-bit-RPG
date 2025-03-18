extends CharacterState

@export var bullet_scene: PackedScene


func _init():
	type = CharacterStates.Type.SHOOT

func enter():
	super.enter()
	play_quip()
	bullet_scene.instantiate().spawn_shot({"character": character})

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		change_state.emit(CharacterStates.Type.IDLE)
