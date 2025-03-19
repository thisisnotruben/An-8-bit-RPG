extends VBoxContainer

var play_focus_sfx := false

# value: yes|no
signal popup_return(value)
signal subcontrol_focused


func display(label: String, yes: String, no: String):
	$header.text = label
	$hBox/yes.text = "  %s  " % yes
	$hBox/no.text = "  %s  " % no

func _on_yes_pressed():
	popup_return.emit("yes")

func _on_no_pressed():
	popup_return.emit("no")

func _on_draw():
	play_focus_sfx = false
	$hBox/no.grab_focus()
	play_focus_sfx = true

func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()
