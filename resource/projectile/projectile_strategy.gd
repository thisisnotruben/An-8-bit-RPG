extends Resource
class_name ProjectileStrategy

@export var damage: AttackType = null
@export var timeout_sec: float = 5.0
@export var snd_hit_sfx: Array[AudioStream] = []
@export var move_strategy: ProjectileMoveBase = null
