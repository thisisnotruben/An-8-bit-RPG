extends CharacterState

var item_scene := preload('uid://dr1an70kj8kym')


func _init():
	type = CharacterStates.Type.DEAD

func enter():
	super.enter()
	character.body.set_deferred('disabled', true)
	character.health_regen.stop()
	character.mana_regen.stop()
	character.ability_regen.stop()
	character.died.emit(character)
	if not character.unit.npc and Input.is_joy_known(0):
		Input.start_joy_vibration(0, 0.0, 1.0, 1.0)

func exit():
	super.exit()
	character.body.set_deferred('disabled', false)
	character.health_regen.start()
	character.mana_regen.start()
	character.ability_regen.start()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active and character.unit.npc:
		# HACK: delayed incase unit casts resurrection
		get_tree().create_timer(10.0).timeout.connect(_on_delayed_queue_free)

		var item_drop := character.unit.drops.get_drop()
		if item_drop and item_drop.type != Item.Type.INVALID:
			var item: ItemPickup = item_scene.instantiate().init(item_drop.type)
			character.add_sibling(item)
			item.global_position = character.global_position

func _on_delayed_queue_free():
	if active:
		character.queue_free()
