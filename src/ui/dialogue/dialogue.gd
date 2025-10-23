extends VBoxContainer

var play_focus_sfx := false

signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited


func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()

func _on_mouse_entered(source: Control):
	subcontrol_mouse_entered.emit(source)

func _on_mouse_exited():
	subcontrol_mouse_exited.emit()

func _on_accept_pressed():
	print("TODO: _on_dialogue_accept_pressed")

func _on_decline_pressed():
	print("TODO: _on_dialogue_decline_pressed")
