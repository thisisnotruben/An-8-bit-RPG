extends Control
class_name GameUISaveLoad

enum Type{ Load, Save, }
const GAME_DATA_PATH := "user://gamedata.json"
const VERSION := "1.0"
const SERIALIZE_GROUP := "serializable"
const DEFAULT_SLOT_NAME := "Game %d"


@export var type := Type.Load: set = _on_set_type
var play_focus_sfx := false
var slot_idx_selected: int = -1

signal back_pressed
signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited


func _ready():
	for bttn in $grid.get_children():
		bttn.text = DEFAULT_SLOT_NAME % (bttn.get_index() + 1)
		bttn.pressed.connect(_on_slot_pressed.bind(bttn.get_index()))
		bttn.mouse_entered.connect(_on_mouse_entered.bind(bttn))
		bttn.mouse_exited.connect(_on_mouse_exited)
		bttn.focus_entered.connect(_on_focus_entered)
	_load_game(-1, _get_save_load_file_data())

func _on_back_pressed():
	back_pressed.emit()

func _on_draw():
	play_focus_sfx = false
	$hBox/back.grab_focus()
	play_focus_sfx = true

func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()

func _on_mouse_entered(source: Control):
	subcontrol_mouse_entered.emit(source)

func _on_mouse_exited():
	subcontrol_mouse_exited.emit()

func _on_slot_pressed(idx: int):
	slot_idx_selected = idx
	print_debug("TODO: _on_slot_pressed, maybe display a little metadata about slot (screenshot)")

func _on_load_save_pressed():
	if slot_idx_selected != -1:
		var payload := _get_save_load_file_data()
		if type == Type.Load:
			_load_game(slot_idx_selected, payload)
		elif type == Type.Save:
			_save_game(slot_idx_selected, payload)

func _on_set_type(value: Type):
	var header_text := ""
	if value == Type.Load:
		header_text = "Load Game"
	elif value == Type.Save:
		header_text = "Save Game"
	$header.text = header_text
	$hBox/load_save.text = header_text

func _get_save_load_file_data() -> Dictionary:
	if FileAccess.file_exists(GAME_DATA_PATH):
		var file := FileAccess.open(GAME_DATA_PATH, FileAccess.READ)
		var json := JSON.new()
		var parsed_result := json.parse(file.get_as_text())
		if parsed_result == Error.OK:
			return json.data
		else:
			printerr("save_load.gd , _get_save_load_file_data(): parsed_result %s", parsed_result)
		file.close()
	return {}

func _load_game(idx: int, payload: Dictionary):
	for header in payload:
		match header:
			"metadata_save_slot_names":
				for slot_idx in payload[header]:
					$grid.get_child(slot_idx).text = payload[header][slot_idx]

			"slot":
				if not payload[header].has(idx):
					continue

				for dserializable_type in payload[header][idx]:
					match dserializable_type:
						"character", "item_slot":
							for node_path in payload[header][idx][dserializable_type]:
								if has_node(node_path):
									get_node(node_path).deserialize(payload[header][idx][dserializable_type][node_path])
								else:
									print("save_load.gd , _load_game() [%s] doesn't exist" % node_path)
						"quest":
							pass

func _save_game(idx: int, master_payload: Dictionary):
	var payload := {
		"version": VERSION,
		"metadata_save_slot_names": {},
		"slot": {
			idx : {
				"character": {},
				"quest": {},
				"item_slot": {}
			}
		}
	}

	for node in get_tree().get_nodes_in_group(SERIALIZE_GROUP):
		if not node.has_method("serialize") or not node.has_method("deserialize"):
			print("save_load.gd, _save_game(): [%s] is not ISerializable" % node.get_path())
			return

		var node_payload: Dictionary = node.serialize()
		if not node_payload.is_empty():
			if node is Character:
				payload["slot"][idx]["character"][node.get_path()] = node_payload
			elif node is HudButton:
				payload["slot"][idx]["item_slot"][node.get_path()] = node_payload

	for slot_idx in payload["slot"].keys():
		payload["metadata_save_slot_names"][slot_idx] = $grid.get_child(slot_idx).text

	if not master_payload.is_empty():
		master_payload["version"] = VERSION
		master_payload["slot"][idx] = payload["slot"][idx]

	var file = FileAccess.open(GAME_DATA_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(master_payload, "\t"))
