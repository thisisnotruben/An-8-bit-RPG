extends Control
class_name GameUISaveLoad

enum Type{ Load, Save, }
const save_load_file_path := "TODO"

@export var type := Type.Load: set = _on_set_type
var play_focus_sfx := false

signal back_pressed
signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited


func _ready():
	for bttn in $grid.get_children():
		bttn.pressed.connect(_on_slot_pressed.bind(bttn.get_index()))
		bttn.mouse_entered.connect(_on_mouse_entered.bind(bttn))
		bttn.mouse_exited.connect(_on_mouse_exited)
		bttn.focus_entered.connect(_on_focus_entered)

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
	print_debug("TODO: _on_slot_pressed")

func _on_load_save_pressed():
	var payload := _get_save_load_file_data()
	if type == Type.Load:
		pass # TODO
	elif type == Type.Save:
		pass

func _on_set_type(value: Type):
	var header_text := ""
	if value == Type.Load:
		header_text = "Load Game"
	elif value == Type.Save:
		header_text = "Save Game"
	$header.text = header_text
	$hBox/load_save.text = header_text

func _get_save_load_file_data() -> Dictionary:
	if FileAccess.file_exists(save_load_file_path):
		var file := FileAccess.open(save_load_file_path, FileAccess.READ)
		var json = JSON.new()
		var parsed_result := json.parse(file.get_as_text())
		if parsed_result == Error.OK:
			return json.data
		else:
			printerr("save_load.gd , _get_save_load_file_data: parsed_result %s", parsed_result)
		file.close()
	return {}
