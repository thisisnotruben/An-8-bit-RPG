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
		
		var tag_values := {}
		for tag in character.get_meta_list():
			match tag:
				'npc':
					tag_values[tag] = character.get_meta(tag)
		if tag_values.is_empty():
			continue
			
		character.unit = character.unit.duplicate()
		for tag in tag_values:
			match tag:
				'npc':
					character.unit.npc = tag_values[tag]
	
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
