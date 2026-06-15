@tool
class_name ProjectileStrategy extends Resource

@export var damage: ModifierAttack = null
@export var timeout_sec: float = 5.0
@export var snd_hit_sfx: Array[AudioStream] = []
@export var move_strategy: ProjectileMoveBase = null


func init(projectile: Projectile) -> ProjectileStrategy:
	projectile.timer.wait_time = timeout_sec
	move_strategy.init(projectile)
	return self
