class_name ActionSummon extends ActionContructor

enum Type { OMNIPRESENT, TEMPORARY, }
enum PosType { SPAWN_POS, }

@export var summoned_type := Type.OMNIPRESENT
@export var pos_type := PosType.SPAWN_POS
@export var node_scene: PackedScene
@export var pos: Vector2


func _init():
	resource_local_to_scene = true

func init(character: Character) -> ActionSummon:
	match pos_type:
		PosType.SPAWN_POS:
			pos = character.global_position
	return self
