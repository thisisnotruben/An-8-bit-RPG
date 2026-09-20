extends Node


func _post_process(base_node: Node2D):
	var character_layer = base_node.get_node_or_null('object/character') as Node2D
	if character_layer:
		character_layer.y_sort_enabled = true
		#for node in character_layer.get_children():
			#if node is Character:
				#node.unit = node.unit
	
	var prop_layer = base_node.get_node_or_null('object/prop') as Node2D
	if prop_layer:
		prop_layer.y_sort_enabled = true
	
	return base_node
