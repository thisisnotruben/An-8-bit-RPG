extends Node
class_name GameCursor

enum Cursor {DEFAULT, HAND, ATTACK, DIALOGUE, BAG}

const arrow := preload("res://resource/texture_ui_cursor_arrow.tres")
const pointing_hand := preload("res://resource/texture_ui_cursor_pointing_hand.tres")
const attack := preload("res://resource/texture_ui_cursor_attack.tres")
const dialogue := preload("res://resource/texture_ui_cursor_dialogue.tres")
const bag := preload("res://resource/texture_ui_cursor_bag.tres")

const map := {
	Cursor.DEFAULT: arrow,
	Cursor.HAND: pointing_hand,
	Cursor.ATTACK: attack,
	Cursor.DIALOGUE: dialogue,
	Cursor.BAG: bag,
}


func _init():
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(pointing_hand, Input.CURSOR_POINTING_HAND)

static func set_cursor(cursor_type: Cursor):
	Input.set_custom_mouse_cursor(map[cursor_type], Input.CURSOR_ARROW)

static func revert_default_cursor():
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW)
