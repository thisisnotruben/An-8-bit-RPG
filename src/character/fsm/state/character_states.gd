extends Node
class_name CharacterStates

# commented with numbers due to anim_tree restrictions
# if new spell created, add it here
enum Type {
	IDLE,    # 0
	MOVE,    # 1
	MELEE,   # 2
	SHOOT,   # 3
	DEAD,    # 4
	SPECIAL, # 5
	HURT,    # 6
	SPELL,   # 7
}
