extends CharacterState

const item_scene := preload("res://src/item/item.tscn")


func _init():
	type = CharacterStates.Type.DEAD
	switch_type = SwitchType.DISABLED

func enter():
	super.enter()
	play_quip(true)

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active and character.npc:

		var all_drops := character.drops
		if not all_drops.is_empty():
			var item_type := ItemDB.Type.INVALID
			if all_drops.keys().size() > 1:
				var roll := randi() % 100 + 1
				var all_drop_pct := all_drops.keys()
				all_drop_pct.sort()
				all_drop_pct.reverse()

				for i in range(1, all_drop_pct):
					all_drop_pct[i] += all_drop_pct[i - 1]

				var choice: int = all_drop_pct[0]
				for pct in all_drop_pct:
					if roll <= pct:
						choice = pct

				item_type = all_drops[all_drop_pct.find(choice)]
			else:
				item_type =  all_drops[all_drops.keys()[0]]

			if item_type != ItemDB.Type.INVALID:
				var item: Item = item_scene.instantiate().init({"type": item_type})
				character.add_sibling(item)
				item.global_position = character.global_position

		character.queue_free()
