extends CharacterState


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
	character.health.reset()
	character.mana.reset()
	character.ability.reset()
	character.health_regen.start()
	character.mana_regen.start()
	character.ability_regen.start()
	character.target = null
	apply_animation(Vector2.DOWN)

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if not active or not character.unit.npc:
		return
		
	var item_drop := character.unit.drops.get_drop()
	if item_drop and item_drop.type != Item.Type.INVALID:
		
		var item: ItemPickup = preload('uid://dr1an70kj8kym') \
			.instantiate().init(item_drop.type)
		character.add_sibling(item)
		item.global_position = character.global_position
		
	await get_tree().create_timer(0.5).timeout
	get_tree().create_tween().tween_property(character, 'modulate', Color.TRANSPARENT, 1.0)
	get_tree().create_timer(character.unit.respawn.get_respawn_time()) \
		.timeout.connect(_on_respawn)

func _on_respawn():
	character.global_position = character.unit.respawn.pos
	get_tree().create_tween().tween_property(character, 'modulate', Color.WHITE, 1.0)
	change_state.emit(CharacterStates.Type.IDLE)
