extends Area2D


func _ready() -> void:
	await get_tree().create_timer(0.25).timeout
	for body in get_overlapping_bodies():
		if body is Character:
			if not body.unit.resource_path.is_empty():
				body.unit = body.unit.duplicate()
				body.unit.make_unique()
			body.unit.roam.init(body, get_path())
