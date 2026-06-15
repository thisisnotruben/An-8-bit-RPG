@tool
class_name GlobalSave extends Resource

@export var datetime = '{year}-{month}-{day} {hour}:{minute}' \
	.format(Time.get_datetime_dict_from_system())
@export var screenshot: PackedByteArray
@export var characters: Array[CharacterSave]
@export var slots: Array[HudSlotSave]


func serialize(tree: SceneTree, scrnshot: PackedByteArray):
	screenshot = scrnshot
	var res: Resource = null
	for node in tree.get_nodes_in_group('serialize'):
		if node is Character:
			res = CharacterSave.new().serialize(node)
			if res != null:
				characters.append(res)
		elif node is HudButton:
			res = HudSlotSave.new().serialize(node)
			if res != null:
				slots.append(res)

func deserialize(tree: SceneTree):
	for data in characters:
		data.deserialize(tree)
	for data in slots:
		data.deserialize(tree)
