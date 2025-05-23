extends CharacterState

@export var bullet_scene: PackedScene


func _init():
	type = CharacterStates.Type.SHOOT
	switch_type = SwitchType.AT_END

func enter():
	super.enter()
	play_quip()
	switch_type_status = SwitchTypeStatus.ACTIVE
	bullet_scene.instantiate().spawn_shot({"character": character})

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
		change_state.emit(CharacterStates.Type.IDLE)
