extends Resource
class_name GameHitFlags

const WORLD_LAYER := 0b00000000_00000000_00000000_00000001
@export_flags_2d_physics var character_hit_flag := 0b00000000_00000000_00000000_00000010
@export_flags_2d_physics var friendly_hit_flag := 0b00000000_00000000_00000000_00000100
@export_flags_2d_physics var foe_hit_flag := 0b00000000_00000000_00000000_00001000
@export_flags_2d_physics var player_hit_flag := 0b00000000_00000000_00000000_00010000


func set_flags(target: Node2D):
	if target is Character:
		var hit_layer := character_hit_flag
		if target.friendly:
			hit_layer += friendly_hit_flag
		else:
			hit_layer += foe_hit_flag
		if not target.npc:
			hit_layer += player_hit_flag

		if target.collision_layer != hit_layer:
			target.set_deferred("collision_layer", hit_layer)

		var hit_scan := WORLD_LAYER
		if target.friendly:
			hit_scan += foe_hit_flag
		else:
			hit_scan += friendly_hit_flag
		if not target.friendly:
			hit_scan += player_hit_flag

		if target.hit_scan_melee.collision_mask != hit_scan:
			target.hit_scan_melee.set_deferred("collision_mask", hit_scan)
		if target.hit_scan_shoot.collision_mask != hit_scan:
			target.hit_scan_shoot.set_deferred("collision_mask", hit_scan)

		var melee_range := Vector2(
			target.stats.melee_stats.attack_range, target.hit_scan_melee.target_position.y)
		var shoot_range := Vector2(
			target.stats.shoot_stats.attack_range, target.hit_scan_shoot.target_position.y)

		if not target.hit_scan_melee.target_position.is_equal_approx(melee_range):
			target.hit_scan_melee.set_deferred("target_position", melee_range)
		if not target.hit_scan_shoot.target_position.is_equal_approx(shoot_range):
			target.hit_scan_shoot.set_deferred("target_position", shoot_range)

	elif target is Projectile:
		var flag_to_hit := foe_hit_flag if target.from_character.friendly else friendly_hit_flag
		target.hit_box.set_deferred("collision_mask", flag_to_hit)
		target.dodge_sight.set_deferred("collision_mask", flag_to_hit)
