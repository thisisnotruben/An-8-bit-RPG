extends Node

#var tree_scene := preload("res://src/map/doodad/tree.tscn")


func _post_process(base_node: Node2D):
	#var trees: Array[Node] = []
	#for node in base_node.get_node("prop").get_children():
		#if node.name.contains("tree"):
			#trees.append(node)
			#var tree := tree_scene.instantiate()
			#node.add_sibling(tree)
			#tree.global_position = node.global_position
	#print(trees)
	#for t in trees:
		#t.queue_free()
#
	#await get_tree().create_timer(5.0).timeout

	return base_node
