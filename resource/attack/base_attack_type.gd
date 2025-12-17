extends Resource
class_name AttackType

enum Type { NORMAL, PIERCE, MAGIC, CHAOS,}

@export var type := Type.NORMAL
@export var amount: int = 1
@export var add := false
