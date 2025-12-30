@tool
class_name CharacterStats extends Resource

const _default_vital: StatModifer = preload('uid://eml2nyacvdlf')
const _default_vital_regen_sec: StatModifer = preload('uid://t5x8lqvvii74')
const _default_vital_regen_amnt: StatModifer = preload('uid://cej4dsuot70pl')

@export var move_speed: StatModifer = preload('uid://dx4fqdca1tv1d')

@export_group('Health')

@export var health_max := _default_vital
@export var health_regen_sec := _default_vital_regen_sec
@export var health_regen_amt := _default_vital_regen_amnt

@export_group('Mana')
@export var mana_max := _default_vital
@export var mana_regen_sec := _default_vital_regen_sec
@export var mana_regen_amt := _default_vital_regen_amnt

@export_group('Agility')
@export var ability_max := _default_vital
@export var ability_regen_sec := _default_vital_regen_sec
@export var ability_regen_amt := _default_vital_regen_amnt

@export_group('Combat')
@export var attack_speed: StatModifer = preload('uid://dswpholksjmce')
@export var melee: CharacterAttackStats = preload('uid://cvn58to2gmt7e')
@export var shoot: CharacterAttackStats = preload('uid://c6wamfb52kyyj')

var target: Character


func init(_target: Node2D):
	target = _target
	if _target is Character:
		var signal_map: Dictionary[StatModifer, Callable] = {
			move_speed: _on_speed_changed,
			health_max: _on_health_max_changed,
			health_regen_amt: _on_health_regen_changed,
			mana_max: _on_mana_max_changed,
			mana_regen_amt: _on_mana_regen_changed,
			ability_max: _on_ability_max_changed,
			ability_regen_amt: _on_ability_regen_changed,
		}

		if not Engine.is_editor_hint():
			signal_map.merge({
				health_regen_sec: _on_health_regen_sec_changed,
				mana_regen_sec: _on_mana_regen_sec_changed,
				ability_regen_sec: _on_ability_regen_sec_changed,
			})

		for stat in signal_map:
			if not stat.on_current_changed.is_connected(signal_map[stat]):
				stat.on_current_changed.connect(signal_map[stat])
			stat.calculate()

		target.health.current = int(health_max.current)
		target.mana.current = int(mana_max.current)
		target.ability.current = int(ability_max.current)

		melee.init(target.hit_scan_melee)
		shoot.init(target.hit_scan_shoot)

func _on_speed_changed(value: float):
	(target.get_node('fsm/move') as Move).speed = value

#region health
func _on_health_max_changed(value: float):
	target.health.max_value = int(value)

func _on_health_regen_sec_changed(value: float):
	target.health_regen.set_timer(value)

func _on_health_regen_changed(value: float):
	target.health_regen.regen_amount = value
#endregion

#region mana
func _on_mana_max_changed(value: float):
	target.mana.max_value = int(value)

func _on_mana_regen_sec_changed(value: float):
	target.mana_regen.set_timer(value)

func _on_mana_regen_changed(value: float):
	target.mana_regen.regen_amount = value
#endregion

#region ability
func _on_ability_max_changed(value: float):
	target.ability.max_value = int(value)

func _on_ability_regen_sec_changed(value: float):
	target.ability_regen.set_timer(value)

func _on_ability_regen_changed(value: float):
	target.ability_regen.regen_amount = value
#endregion

func _on_attack_speed_changed(_value: float):
	print_debug('TODO: need to implement this in the Character [behavior_tree]')
