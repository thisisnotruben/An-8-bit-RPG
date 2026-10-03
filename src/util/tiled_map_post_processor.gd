extends Node


func _post_process(base_node: Node2D):
	CharacterBuilder.IMPORTING = true
	
	var object_layer := base_node.get_node('object') as Node2D
	var character_layer := object_layer.get_node_or_null('character') as Node2D
	var prop_layer := object_layer.get_node_or_null('prop') as Node2D
	var roam_layer := object_layer.get_node_or_null('roam') as Node2D
	
	object_layer.y_sort_enabled = true
	
	var character_ids: Dictionary[int, Character] = {}
	for node in character_layer.get_children():
		var character := node as Character
		if not character:
			continue
		
		character_ids.set(character.get_meta('id'), character)
		var valid_tags := ['npc', 'character_name', 'health_max', \
			'melee_damage', 'tag', ]
		
		var tag_values := {}
		for tag in character.get_meta_list():
			if valid_tags.has(tag):
				tag_values[tag] = character.get_meta(tag)
		if tag_values.is_empty():
			continue
			
		character.unit = character.unit.duplicate()
		character.unit.make_unique()
		
		for tag in tag_values:
			match tag:
				'melee_damage':
					(character.unit.stats.melee.damage.modifier.base as ModifierAmount)._amount = tag_values[tag]
				'health_max':
					(character.unit.stats.health_max.base as ModifierAmount)._amount = tag_values[tag]
				'tag':
					for t in tag_values[tag]:
						if not character.unit.tags.has(t):
							character.unit.tags.append(t)
				_ when valid_tags.has(tag):
					character.unit.set(tag, tag_values[tag])
					
	if character_layer and prop_layer:
		while character_layer.get_child_count() > 0:
			character_layer.get_child(0).reparent(object_layer)
		while prop_layer.get_child_count() > 0:
			prop_layer.get_child(0).reparent(object_layer)
		character_layer.free()
		prop_layer.free()
		
	for group in base_node.get_children():
		for node in group.get_children():
			if node.is_in_group('top_level'):
				node.top_level = true
				
	var make_unique := func(c: Character): 
		if not c.unit.resource_path.is_empty():
			c.unit = c.unit.duplicate()
			c.unit.make_unique()
				
	for node in roam_layer.get_children():
		var node_path := NodePath('../%s/%s' % [roam_layer.name, node.name])
		
		if node is Path2D:
			var character := character_ids[int(node.get_meta('character_id'))]
			make_unique.call(character)
			character.unit.roam.node_path = node_path
			continue
			
		var area2D = node as Area2D
		if not area2D:
			continue
			
		if area2D.get_meta('is_explicit_characters', false):
			for id in area2D.get_meta('roams', []):
				var character: Character = character_ids.get(int(id))
				if character:
					make_unique.call(character)
					character.unit.roam.node_path = node_path
					
		else:
			# NOTICE: have to do this because,
			# areas can't detect in import process
			area2D.set_script(preload('uid://dyhukjskt3r'))
			
	return base_node
