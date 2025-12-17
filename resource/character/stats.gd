extends Resource
class_name CharacterStats

@export_category("Health")
@export_range(1, 10) var health_max: int = 2
@export_range(1.0, 90.0, 0.1) var health_regen_sec: float = 30.0
@export_range(1, 10) var health_regen_amt: int = 1

@export_category("Mana")
@export_range(1, 10) var mana_max: int = 2
@export_range(1.0, 90.0, 0.1) var mana_regen_sec: float = 30.0
@export_range(1, 10) var mana_regen_amt: int = 1

@export_category("Agility")
@export_range(1, 10) var ability_max: int = 2
@export_range(1.0, 90.0, 0.1) var ability_regen_sec: float = 30.0
@export_range(1, 10) var ability_regen_amt: int = 1

@export_category("Combat")
@export var melee_stats: CharacterAttackStats
@export var shoot_stats: CharacterAttackStats


func set_stats(target: Node2D):
	if target is Character:
		target.health.max_value = health_max
		target.health.current = health_max
		target.health_regen.regen_amount = health_regen_amt
		target.health_regen.set_timer(health_regen_sec)

		target.mana.max_value = mana_max
		target.mana.current = mana_max
		target.mana_regen.regen_amount = mana_regen_amt
		target.mana_regen.set_timer(mana_regen_sec)

		target.ability.max_value = ability_max
		target.ability.current = ability_max
		target.ability_regen.regen_amount = ability_regen_amt
		target.ability_regen.set_timer(ability_regen_sec)
