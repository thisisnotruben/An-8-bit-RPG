extends Resource
class_name ArmorType

enum Type { UNARMORED, LIGHT, MEDIUM, HEAVY, FORTIFIED, DIVINE, }

@export var type := Type.UNARMORED
@export var amount: int = 1
