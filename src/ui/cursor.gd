class_name GameCursor extends Node

enum Cursor {DEFAULT, HAND, ATTACK, DIALOGUE, BAG}

const arrow := preload("uid://ev1yg26v2q1o")
const pointing_hand := preload("uid://nw30g6et71ym")
const attack := preload("uid://dyltp5mo1hlq")
const dialogue := preload("uid://be8gm8iwmn67r")
const bag := preload("uid://da1wwh6wk8k5y")

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
