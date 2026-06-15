extends ProjectileMoveState


func _init():
	type = Type.LINEAR

func physics_process(delta: float):
	projectile.global_position += projectile.direction * speed * delta
