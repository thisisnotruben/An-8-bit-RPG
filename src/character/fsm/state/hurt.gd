extends CharacterState


func _init():
	type = CharacterStates.Type.HURT
	switch_type = SwitchType.AT_END

func enter():
	super.enter()
	switch_type_status = SwitchTypeStatus.ACTIVE
	if not character.unit.npc and Input.is_joy_known(0):
		Input.start_joy_vibration(0, 1.0, 0.0, 0.5)

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
