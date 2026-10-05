extends Area2D


func _ready() -> void:
	monitorable = false
	await get_tree().create_timer(1.0).timeout
	for body in get_overlapping_bodies():
		if body is Character:
			if not body.unit.resource_path.is_empty():
				body.unit = body.unit.duplicate()
				body.unit.make_unique()
			body.unit.roam.init(body, get_path())
