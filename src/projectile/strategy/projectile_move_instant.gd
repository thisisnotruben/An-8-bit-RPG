extends ProjectileMoveState


func _init():
	type = Type.INSTANT

func enter():
	projectile.global_position = projectile.seek_pos
