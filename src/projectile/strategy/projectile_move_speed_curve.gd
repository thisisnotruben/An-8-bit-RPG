extends ProjectileMoveState

@export var until_type := UntilType.EXPIRE
@export var curve: Curve = null

var sec_elapsed := 0.0
var pct := 0.0
var estimated_total_sec := 0.0
var spawned_distance_to_target := 0.0


func _init():
	type = Type.SPEED_CURVE

func enter():
	if until_type == UntilType.POS:
		spawned_distance_to_target = \
			projectile.global_position.distance_to(projectile.seek_pos)

		var cum_sum := 0.0
		var samples := range(0, 100, 5)
		for i in samples:
			cum_sum += curve.sample(float(i) / 100.0)
		estimated_total_sec = cum_sum / samples.size()
		estimated_total_sec = estimated_total_sec / spawned_distance_to_target

func physics_process(delta: float):
	match until_type:
		UntilType.EXPIRE:
			sec_elapsed += delta
			pct = sec_elapsed / projectile.timer.wait_time
		UntilType.POS:
			pct = 1.0 - projectile.global_position.distance_to( \
				projectile.seek_pos) / spawned_distance_to_target

	projectile.global_position += projectile.direction * speed * delta \
	 	* curve.sample(minf(pct, 1.0))
