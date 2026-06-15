class_name ProjectileMoveState extends IState

enum Type{ INVALID, STOPPED, INSTANT, LINEAR, SPEED_CURVE, TWEEN, }
enum UntilType { EXPIRE, POS, }

@export var speed: float = 64.0
@export var projectile: Projectile = null
var type := Type.STOPPED
