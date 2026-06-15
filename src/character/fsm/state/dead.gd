extends CharacterState

@export var item_scene: PackedScene


func _init():
	type = CharacterStates.Type.DEAD

func enter():
	super.enter()
	character.health_regen.stop()
	character.mana_regen.stop()
	character.ability_regen.stop()
	character.died.emit()
	if not character.unit.npc and Input.is_joy_known(0):
		Input.start_joy_vibration(0, 0.0, 1.0, 1.0)

func exit():
	super.exit()
	character.health_regen.start()
	character.mana_regen.start()
	character.ability_regen.start()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active and character.unit.npc:

		# HACK: delayed incase unit casts resurrection
		get_tree().create_timer(10.0).timeout.connect(_on_delayed_queue_free)

		var all_drops := character.unit.drops
		if not all_drops.is_empty():
			var item_type := Item.Type.INVALID
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

			if item_type != Item.Type.INVALID:
				ItemDB.get_item(item_type)
				var item: ItemPickup = item_scene.instantiate().init(item_type)
				character.add_sibling(item)
				item.global_position = character.global_position

func _on_delayed_queue_free():
	if active:
		character.queue_free()
