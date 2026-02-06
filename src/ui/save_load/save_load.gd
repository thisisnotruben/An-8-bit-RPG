extends Control
class_name GameUISaveLoad

enum Type{ Load, Save, }
const SCREENSHOT_PATH := 'user://game%d.png'
const DEFAULT_SLOT_NAME := 'Game %d'

@onready var slots: Control = $hBox/scroll/vBox
@onready var slot_save_image: TextureRect = $hBox/texture

@export var type := Type.Load:
	set(value):
		if not is_node_ready():
			await ready

		type = value
		var header_text := ''
		if value == Type.Load:
			header_text = 'Load Game'
		elif value == Type.Save:
			header_text = 'Save Game'
		$header.text = header_text
		$hBox2/load_save.text = header_text

var play_focus_sfx := false
var slot_idx_selected: int = -1
var screenshot: ViewportTexture = null
var screenshots: Array[Texture] = []
var prev_toggled: CheckBox = null

signal back_pressed
signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited


func _ready():
	screenshots.resize(slots.get_child_count())

	for bttn in slots.get_children():
		bttn.text = DEFAULT_SLOT_NAME % (bttn.get_index() + 1)
		bttn.pressed.connect(_on_slot_pressed.bind(bttn.get_index()))
		bttn.toggled.connect(_on_slot_toggled.bind(bttn))
		bttn.mouse_entered.connect(_on_mouse_entered.bind(bttn))
		bttn.mouse_exited.connect(_on_mouse_exited)
		bttn.focus_entered.connect(_on_focus_entered)

	for i in slots.get_child_count():
		_load_game(i, true)

func _on_back_pressed():
	back_pressed.emit()

func _on_draw():
	play_focus_sfx = false
	$hBox2/back.grab_focus()
	play_focus_sfx = true

func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()

func _on_mouse_entered(source: Control):
	subcontrol_mouse_entered.emit(source)

func _on_mouse_exited():
	subcontrol_mouse_exited.emit()

func _on_slot_pressed(idx: int):
	prev_toggled = slots.get_child(idx)
	slot_idx_selected = idx
	slot_save_image.texture = screenshots[idx]

func _on_slot_toggled(toggled_on: bool, source: CheckBox):
	if prev_toggled == null:
		prev_toggled = source
	elif toggled_on and source != prev_toggled:
		prev_toggled.button_pressed = false

func _on_load_save_pressed():
	if slot_idx_selected != -1:
		if type == Type.Load:
			_load_game(slot_idx_selected)
		elif type == Type.Save:
			_save_game(slot_idx_selected)

func _load_game(idx: int, is_preloaded := false):
	var load_file := SaveFile.load_from_device_or_cache()
	if not is_preloaded:
		load_file.deserialize(get_tree(), idx)
	for i in slots.get_child_count() - 1:
		if load_file.slots[i]:
			(slots.get_child(i) as Button).text = load_file.slots[i].datetime
			screenshots.set(i, Image.new().load_png_from_buffer(load_file.slots[i].screenshot))

func _save_game(idx: int):
	var screenshot_buffer: PackedByteArray = []
	if screenshot:
		screenshots[idx] = screenshot
		screenshot_buffer = screenshot.get_image().save_png_to_buffer()
	SaveFile.load_from_device_or_cache().serialize(get_tree(), idx, screenshot_buffer)
