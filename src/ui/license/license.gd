extends VBoxContainer

var play_focus_sfx := false

signal back_pressed
signal subcontrol_focused


func _on_back_pressed():
	back_pressed.emit()

func _on_draw():
	play_focus_sfx = false
	$back.grab_focus()
	play_focus_sfx = true

func _on_redirect_pressed():
	$snd.play()
	await $snd.finished
	OS.shell_open("https://github.com/thisisnotruben/Starship-Invasion/blob/main/LICENSE.md")

func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()
