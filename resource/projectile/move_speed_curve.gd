extends ProjectileMoveBase
class_name ProjectileSpeedCurve

@export var speed := 64.0
@export var until_type: ProjectileMoveState.UntilType
@export var curve: Curve = null


func _init():
	type = ProjectileMoveState.Type.SPEED_CURVE
