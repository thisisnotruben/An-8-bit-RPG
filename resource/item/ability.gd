class_name Ability extends Item

enum TargetType { USER, TARGET, NONE, }

@export var cost_type: ActionModifyAttribute.TypeAttribute
@export var cost: ModifierAttack
@export var target_type := TargetType.USER
@export var cast_time: float
@export var projectile_strategy: ProjectileStrategy
## Does this ability cast again without manually doing so?
@export var autocast: bool
## When added to inventory, does the ability automatically cast?
@export var passive: bool


func take_cost(character: Character):
	var stat_component: StatComponent
	match cost_type:
		ActionModifyAttribute.TypeAttribute.HEALTH:
			stat_component = character.health
		ActionModifyAttribute.TypeAttribute.MANA:
			stat_component = character.mana
		ActionModifyAttribute.TypeAttribute.ABILITY:
			stat_component = character.ability
		_:
			return
	stat_component.modify(cost)
