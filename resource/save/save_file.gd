class_name SaveFile extends Resource

const GAME_DATA_PATH := 'user://gamedata.json'
enum Versions { v1, }

@export var version := Versions.v1
@export var slots: Array[GlobalSave]
@export var slots_amnt: int = 10


func _init():
	slots.resize(slots_amnt)

func serialize(tree: SceneTree, slot_idx: int, screenshot: PackedByteArray) -> SaveFile:
	slots.set(slot_idx, GlobalSave.new().serialize(tree, screenshot))
	return self

func deserialize(tree: SceneTree, slot_idx: int):
	if slots.get(slot_idx):
		slots.get(slot_idx).deserialize(tree)

func save_to_device():
	ResourceSaver.save(self, GAME_DATA_PATH)

static func load_from_device_or_cache() -> SaveFile:
	if ResourceLoader.exists(GAME_DATA_PATH):
		return ResourceLoader.load(GAME_DATA_PATH)
	return SaveFile.new()
