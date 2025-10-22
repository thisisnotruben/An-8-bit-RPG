extends VBoxContainer

var play_focus_sfx := false

signal back_pressed
signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited


func _on_back_pressed():
	back_pressed.emit()

func _on_draw():
	play_focus_sfx = false
	$back.grab_focus()
	play_focus_sfx = true

func _on_redirect_pressed():
	$snd.play()
	await $snd.finished
	OS.shell_open("https://github.com/thisisnotruben/An-8-bit-RPG/blob/main/LICENSE.md")

func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()

func _on_mouse_entered(source: Control):
	subcontrol_mouse_entered.emit(source)

func _on_mouse_exited():
	subcontrol_mouse_exited.emit()
