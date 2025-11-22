extends VBoxContainer

@export var player: Character = null

var play_focus_sfx := false

signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited
signal close_panel


@onready var header: Label = $vBox_header/name
@onready var header_icon: TextureRect = $vBox_header/icon
@onready var blurb: Label = $scroll/dialogue
@onready var accept_bttn: Button = $action/accept
@onready var decline_bttn: Button = $action/decline
@onready var complete_bttn: Button = $action/complete


func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()

func _on_mouse_entered(source: Control):
	subcontrol_mouse_entered.emit(source)

func _on_mouse_exited():
	subcontrol_mouse_exited.emit()

func _on_accept_pressed():
	$snd_accept.play()
	_check_quests()
	close_panel.emit()

func _on_decline_pressed():
	$snd_decline.play()
	close_panel.emit()

func _on_complete_pressed():
	$snd_complete.play()
	_check_quests()

func _check_quests():
	if player != null and player.target != null:
		QuestDB.check_quests({"search_key": player.target.get_path()})

func display():
	if player != null and player.target != null:
		var data := QuestDB.get_data({"search_key": player.target.get_path()})
		if data == null:
			return

		header.text = data.quest_name
		header_icon.texture = player.target.img.texture

		var is_quest_started := not data.active and not data.completed
		var is_quest_active := data.active and not data.completed
		var is_quest_delievered := not data.active and data.completed

		accept_bttn.visible = is_quest_started
		decline_bttn.visible = is_quest_started
		complete_bttn.visible = is_quest_active and data.is_completable()

		var text := ""
		if is_quest_started:
			text = data.quest_start_blurb
		elif is_quest_active:
			text = data.quest_active_blurb
		elif is_quest_delievered:
			text = data.quest_delivered_blurb
		blurb.text = text
