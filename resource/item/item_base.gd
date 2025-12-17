extends Resource
class_name BaseItem

enum Category {
	NOT_SET, # 0
	HEALTH,  # 1
	MANA,    # 2
	ABILITY, # 3
	WEAPON,  # 4
	ARMOR,   # 5
	MISC,    # 6
	QUEST,   # 7
	SPELL,   # 8
}
enum Type {
	INVALID,
}

@export var icon: Texture
@export var type := Type.INVALID
@export var category := Category.NOT_SET
@export var behavior: BehaviorTree
@export var behavior_cooldown := 0.0
