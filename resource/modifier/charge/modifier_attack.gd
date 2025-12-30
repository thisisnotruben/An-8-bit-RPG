@tool
class_name ModifierAttack extends Resource

enum Type { NORMAL, PIERCE, MAGIC, CHAOS, }

@export var type := Type.NORMAL
@export var modifier: StatModifer
@export var add := false
