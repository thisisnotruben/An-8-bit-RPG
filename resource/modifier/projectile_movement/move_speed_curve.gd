@tool
class_name ProjectileSpeedCurve extends ProjectileMoveBase

@export var speed := 64.0
@export var until_type: ProjectileMoveState.UntilType
@export var curve: Curve = null


func _init():
	type = ProjectileMoveState.Type.SPEED_CURVE

func init(projectile: Projectile) -> ProjectileMoveBase:
	var state: ProjectileMoveState = projectile.fsm.states[type]
	state.speed = speed
	state.until_type = until_type
	state.curve = curve
	return self
