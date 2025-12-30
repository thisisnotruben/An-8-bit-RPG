@tool
class_name CharacterAttackStats extends Resource

@export var damage: ModifierAttack
@export_range(0.0, 64.0) var attack_range: float = 16.0


func init(ray_cast: RayCast2D):
	var attack_range_vec := Vector2(attack_range, ray_cast.target_position.y)
	if not ray_cast.target_position.is_equal_approx(attack_range_vec):
		ray_cast.set_deferred('target_position', attack_range_vec)
