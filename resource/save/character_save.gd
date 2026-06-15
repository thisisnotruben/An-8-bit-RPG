class_name CharacterSave extends Resource

@export var builder: CharacterBuilder
@export var global_position: Vector2
@export var health: int
@export var mana: int
@export var ability: int
@export var path: NodePath


func serialize(character: Character) -> CharacterSave:
	builder = character.unit
	health = character.health.current
	mana = character.mana.current
	ability = character.ability.current
	global_position = character.global_position
	path = character.get_path()
	return self

func deserialize(tree: SceneTree):
	var character := tree.current_scene.get_node_or_null(path)
	if not character:
		return

	character.unit = builder
	character.health.current = health
	character.mana.current = mana
	character.ability.current = ability
	character.global_position = global_position
