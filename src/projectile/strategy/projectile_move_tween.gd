extends ProjectileMoveState

@export var until_type := UntilType.EXPIRE
@export var transition_type := Tween.TransitionType.TRANS_LINEAR
@export var ease_type := Tween.EaseType.EASE_IN


func _init():
	type = Type.TWEEN

func enter():
	var tween := get_tree().create_tween().set_trans(transition_type).set_ease(ease_type)
	match until_type:
		UntilType.EXPIRE:
			tween.tween_property(projectile, "global_position",
				projectile.global_position + projectile.direction *
				speed * projectile.timer.wait_time, projectile.timer.wait_time)

		UntilType.POS:
			tween.tween_property(projectile, "global_position",
				projectile.seek_pos, projectile.global_position.distance_to(
					projectile.seek_pos) / speed)
