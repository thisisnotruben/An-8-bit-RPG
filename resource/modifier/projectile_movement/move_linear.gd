@tool
class_name ProjectileLinear extends ProjectileMoveBase

@export var speed := 64.0


func _init():
	type = ProjectileMoveState.Type.LINEAR

func init(projectile: Projectile) -> ProjectileMoveBase:
	(projectile.fsm.states[type] as ProjectileMoveState).speed = speed
	return self
