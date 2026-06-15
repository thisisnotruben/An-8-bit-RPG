@tool
class_name ModifierDefense extends Resource

enum Type { UNARMORED, LIGHT, MEDIUM, HEAVY, FORTIFIED, DIVINE, }

@export var type := Type.UNARMORED
@export var modifier: ModifierAmountBase
@export var add: bool
