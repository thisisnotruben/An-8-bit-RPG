extends Node


func _post_process(base_node: Node2D):
	
	var object_layer := base_node.get_node('object') as Node2D
	var character_layer := object_layer.get_node_or_null('character') as Node2D
	var prop_layer := object_layer.get_node_or_null('prop') as Node2D
	
	object_layer.y_sort_enabled = true
	
	for node in character_layer.get_children():
		var character := node as Character
		if not character:
			continue
		
		var valid_tags := ['npc', 'character_name', 'health_max', \
			'melee_damage', 'tag',]
		
		var tag_values := {}
		for tag in character.get_meta_list():
			if valid_tags.has(tag):
				tag_values[tag] = character.get_meta(tag)
		if tag_values.is_empty():
			continue
			
		character.unit = character.unit.duplicate()
		var stats: CharacterStats = character.unit.stats \
			.duplicate_deep(Resource.DeepDuplicateMode.DEEP_DUPLICATE_ALL)
		var has_modified_stats := false
		
		for tag in tag_values:
			match tag:
				'melee_damage':
					(stats.melee.damage.modifier.base as ModifierAmount)._amount = tag_values[tag]
					has_modified_stats = true
				'health_max':
					(stats.health_max.base as ModifierAmount)._amount = tag_values[tag]
					has_modified_stats = true
				'tag':
					for t in tag_values[tag]:
						if not character.unit.tags.has(t):
							character.unit.tags.append(t)
				_ when valid_tags.has(tag):
					character.unit.set(tag, tag_values[tag])
					
		if has_modified_stats:
			character.unit.stats = stats
				
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
			
	return base_node
