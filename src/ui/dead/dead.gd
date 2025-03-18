extends VBoxContainer

var play_focus_sfx := false

@export var start_level_scene: PackedScene = null
@export var tab: TabContainer = null
@export var popup: Control = null
var tabs = { } # set by game_menu code

signal subcontrol_focused


func _on_draw():
	play_focus_sfx = false
	$start_menu.grab_focus()
	play_focus_sfx = true

func _on_start_menu_pressed():
	$snd_popup.play()
	popup.display("Go to Start Menu?", "Go", "Stay")
	tab.current_tab = tabs["popup"]
	if await popup.popup_return == "yes":
		$snd_start.play()
		popup.get_node("hBox/yes").release_focus()
		await $snd_start.finished
		get_tree().paused = false
		get_tree().change_scene_to_packed(start_level_scene)
	else:
		$snd_back.play()
		tab.current_tab = tabs["dead"]

func _on_checkpoint_pressed():
	pass # TODO: Replace with function body.

func _on_focus_entered():
	if play_focus_sfx:
		emit_signal("subcontrol_focused")
