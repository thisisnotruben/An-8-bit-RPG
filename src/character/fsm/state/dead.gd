extends CharacterState

func _init():
	type = CharacterStates.Type.DEAD
	switch_type = SwitchType.DISABLED

func enter():
	super.enter()
	play_quip(true)

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active and character.npc:
		if character.drop != null and character.drop_percent > 0.0 \
		and character.drop_percent > randf():
			var item: Node2D = character.drop.instantiate()
			character.add_sibling(item)
			item.name = str(Item.Type.keys()[item.type])
			item.global_position = character.global_position
		character.queue_free()
