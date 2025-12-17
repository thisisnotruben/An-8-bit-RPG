extends Control

const tabs := {"main": 0, "license": 1, "credits": 2, "popup": 3}

@export_file("*.tscn") var game_level_scene_path := ""

var play_focus_sfx := false
var hovered_control: Control = null

@onready var tab: TabContainer = $center/panel/margin/tabs
@onready var popup: Control = $center/panel/margin/tabs/popup
@onready var prev_tab: Control = $center/panel/margin/tabs/main/start


func _ready():
	randomize()

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		match tab.current_tab:
			tabs["license"], tabs["credits"]:
				_on_back_pressed()
			tabs["popup"]:
				popup._on_no_pressed()

func _on_focus_entered():
	if play_focus_sfx:
		$snd_nav.play()

func _on_mouse_entered(source: Control):
	if source:
		hovered_control = source
		source.grab_focus()
		source.release_focus()

func _on_mouse_exited():
	if hovered_control:
		play_focus_sfx = false
		hovered_control.grab_focus()
		play_focus_sfx = true

func _on_start_pressed():
	prev_tab = $center/panel/margin/tabs/main/start
	prev_tab.release_focus()
	$snd_game.play()
	await $snd_game.finished
	get_tree().change_scene_to_file(game_level_scene_path)

func _on_license_pressed():
	$snd.play()
	prev_tab = $center/panel/margin/tabs/main/grid/license
	tab.current_tab = tabs["license"]

func _on_credits_pressed():
	$snd.play()
	prev_tab = $center/panel/margin/tabs/main/grid/credits
	tab.current_tab = tabs["credits"]

func _on_exit_pressed():
	$snd_popup.play()
	popup.display("Exit Game?", "Exit", "Stay")
	tab.current_tab = tabs["popup"]
	prev_tab = $center/panel/margin/tabs/main/exit
	if await popup.popup_return == "yes":
		$snd_exit.play()
		$center/panel/margin/tabs/popup/hBox/yes.release_focus()
		await $snd_exit.finished
		get_tree().quit()
	else:
		$snd_back.play()
		tab.current_tab = tabs["main"]

func _on_back_pressed():
	$snd_back.play()
	tab.current_tab = tabs["main"]

func _on_main_draw():
	play_focus_sfx = false
	prev_tab.grab_focus()
	play_focus_sfx = true
