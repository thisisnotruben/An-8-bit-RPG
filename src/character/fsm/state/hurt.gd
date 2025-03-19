extends CharacterState


func _init():
	type = CharacterStates.Type.HURT
	switch_type = SwitchType.AT_END

func enter():
	super.enter()
	play_quip()
	switch_type_status = SwitchTypeStatus.ACTIVE

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
