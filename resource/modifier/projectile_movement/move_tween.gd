@tool
class_name ProjectileTween extends ProjectileMoveBase

@export var speed := 64.0
@export var until_type: ProjectileMoveState.UntilType
@export var transition_type: Tween.TransitionType
@export var ease_type: Tween.EaseType


func _init():
	type = ProjectileMoveState.Type.TWEEN

func init(projectile: Projectile) -> ProjectileMoveBase:
	var state: ProjectileMoveState = projectile.fsm.states[type]
	state.speed = speed
	state.until_type = until_type
	state.transition_type = transition_type
	state.ease_type = ease_type
	return self
