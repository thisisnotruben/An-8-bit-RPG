extends CharacterState

@export var bullet_scene: PackedScene


func _init():
	type = CharacterStates.Type.SHOOT
	switch_type = SwitchType.AT_END

func enter():
	super.enter()
	play_quip()
	switch_type_status = SwitchTypeStatus.ACTIVE

	var args := {
		"character": character,
		"direction": Vector2(
			cos(character.hit_scan_shoot.rotation),
			sin(character.hit_scan_shoot.rotation)).normalized(),
		"seek_pos": character.target.global_position,
	}

	var projectile: Projectile = bullet_scene.instantiate().init(args)
	character.add_sibling(projectile)
	projectile.global_position = character.hit_scan_shoot.global_position
	projectile.enter()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED
