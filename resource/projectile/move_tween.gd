extends ProjectileMoveBase
class_name ProjectileTween

@export var speed := 64.0
@export var until_type: ProjectileMoveState.UntilType
@export var transition_type: Tween.TransitionType
@export var ease_type: Tween.EaseType


func _init():
	type = ProjectileMoveState.Type.TWEEN
