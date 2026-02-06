@tool
class_name GlobalSave extends Resource

@export var datetime = '{year}-{month}-{day} {hour}:{minute}' \
	.format(Time.get_datetime_dict_from_system())
@export var screenshot: PackedByteArray
@export var characters: Array[CharacterSave]
@export var slots: Array[HudSlotSave]


func serialize(tree: SceneTree, scrnshot: PackedByteArray):
	screenshot = scrnshot
	for node in tree.get_nodes_in_group('serialize'):
		if node is Character:
			characters.append(CharacterSave.new().serialize(node))
		elif node is HudButton:
			slots.append(HudSlotSave.new().serialize(node))

func deserialize(tree: SceneTree):
	for data in characters:
		data.deserialize(tree)
	for data in slots:
		data.deserialize(tree)
