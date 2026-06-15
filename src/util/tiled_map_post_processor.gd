extends Node


func _post_process(base_node: Node2D):
	base_node.get_node('character').y_sort_enabled = true
	base_node.get_node('prop').y_sort_enabled = true
	return base_node
