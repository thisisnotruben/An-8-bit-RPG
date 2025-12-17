extends ActionContructor
class_name ActionSummon

enum Type{ OMNIPRESENT, TEMPORARY, }

@export var summoned_type := Type.OMNIPRESENT
@export var node_scene: PackedScene
@export var pos: Vector2
