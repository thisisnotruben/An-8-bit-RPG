extends Control

const tabs := {"main": 0, "license": 1, "credits": 2,
"popup": 3, "dead": 4, "save_load": 5,}

@export var player: Character = null
@export_file("*.tscn") var start_level_scene_path := ""

var play_focus_sfx := false
var dead := false
var hovered_control: Control = null

@onready var tab: TabContainer = $center/panel/margin/tabs
@onready var popup: Control = $center/panel/margin/tabs/popup
@onready var prev_tab: Control = $center/panel/margin/tabs/main/resume_game
@onready var save_load: GameUISaveLoad = $center/panel/margin/tabs/save_load


func _ready():
	visibility_changed.connect(_on_visibility_changed)
	if player != null:
		player.died.connect(show_death_screen)

func _input(event: InputEvent):
	if dead:
		return

	if event.is_action_pressed("ui_cancel") \
	and tab.current_tab == tabs["main"]:
		if not visible:
			await RenderingServer.frame_post_draw
			save_load.screenshot = get_viewport().get_texture()
		visible = not visible
		if visible:
			$snd_pause.play()
		else:
			$snd_resume.play()
	elif event.is_action_pressed("ui_cancel"):
		match tab.current_tab:
			tabs["license"], tabs["credits"], tabs["save_load"]:
				_on_back_pressed()
			tabs["popup"]:
				popup._on_no_pressed()

func _on_focus_entered():
	if play_focus_sfx:
		$snd_nav.play()

func _on_mouse_entered(source: Control):
	if source != null:
		hovered_control = source
		source.grab_focus()
		source.release_focus()

func _on_mouse_exited():
	if hovered_control != null:
		play_focus_sfx = false
		hovered_control.grab_focus()
		play_focus_sfx = true

func _on_resume_game_pressed():
	$snd_resume.play()
	hide()

func _on_start_menu_pressed():
	$snd_popup.play()
	popup.display("Go to Start Menu?", "Go", "Stay")
	prev_tab = $center/panel/margin/tabs/main/start_menu
	tab.current_tab = tabs["popup"]
	if await popup.popup_return == "yes":
		$snd_start.play()
		$center/panel/margin/tabs/popup/hBox/yes.release_focus()
		await $snd_start.finished
		get_tree().paused = false
		get_tree().change_scene_to_file(start_level_scene_path)
	else:
		$snd_back.play()
		tab.current_tab = tabs["main"]

func _on_save_pressed():
	$snd.play()
	prev_tab = $center/panel/margin/tabs/main/grid/save
	tab.get_child(tabs["save_load"]).type = GameUISaveLoad.Type.Save
	tab.current_tab = tabs["save_load"]

func _on_load_pressed():
	$snd.play()
	prev_tab = $center/panel/margin/tabs/main/grid/load
	tab.get_child(tabs["save_load"]).type = GameUISaveLoad.Type.Load
	tab.current_tab = tabs["save_load"]

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

func _on_visibility_changed():
	if not dead and is_inside_tree() and get_tree() != null:
		get_tree().paused = visible
		if not visible:
			tab.current_tab = tabs["main"]
			prev_tab = $center/panel/margin/tabs/main/resume_game

func show_death_screen():
	await get_tree().create_timer(2.5).timeout
	tab.current_tab = tabs["dead"]
	show()
