extends CharacterState

@export var bullet_scene: PackedScene
var shot_projectiles_with_ability: Dictionary[Projectile, AbilityPlayer]


func _init():
	type = CharacterStates.Type.SHOOT
	switch_type = SwitchType.AT_END

func enter():
	super.enter()
	switch_type_status = SwitchTypeStatus.ACTIVE

	var projectile := (bullet_scene.instantiate() as Projectile).init(
		character,
		Vector2(
			cos(character.hit_scan_shoot.rotation),
			sin(character.hit_scan_shoot.rotation)).normalized(),
		character.target.global_position)

	if blackboard.has(LimboVarLib.ABILITY_PLAYER):
		projectile.on_entered.connect(_on_projectile_entered)
		projectile.on_hit.connect(_on_projectile_hit)
		projectile.on_expired.connect(_on_projectile_expired)

		shot_projectiles_with_ability.set(projectile, blackboard.get(LimboVarLib.ABILITY_PLAYER))
		blackboard.erase(LimboVarLib.ABILITY_PLAYER)

	character.add_sibling(projectile)
	projectile.global_position = character.hit_scan_shoot.global_position
	projectile.enter()

func _on_animation_tree_animation_finished(_anim_name: StringName):
	if active:
		switch_type_status = SwitchTypeStatus.FINISHED

#region Linking projectiles with an Ability
func _on_projectile_entered(projectile: Projectile):
	shot_projectiles_with_ability[projectile].enter()

func _on_projectile_hit(projectile: Projectile, hit_character: Character):
	shot_projectiles_with_ability[projectile].blackboard.set_var(LimboVarLib.ON_HIT, true)
	shot_projectiles_with_ability[projectile].blackboard.set_var(LimboVarLib.CHARACTER, hit_character)
	shot_projectiles_with_ability.erase(projectile)

func _on_projectile_expired(projectile: Projectile):
	shot_projectiles_with_ability.erase(projectile)
#endregion
