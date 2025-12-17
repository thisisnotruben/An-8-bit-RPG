extends ProjectileMoveBase
class_name ProjectileLinear

@export var speed := 64.0


func _init():
	type = ProjectileMoveState.Type.LINEAR
