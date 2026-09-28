extends Control

var play_focus_sfx := false
var last_focused_entry: Control = null

signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited

@onready var tab: TabContainer = $tabs
@onready var tab_bar: TabBar = tab.get_tab_bar()
@onready var tab_size_x: float = tab.custom_minimum_size.x / 2.0
var tabs := {'active': 0, 'finished': 1}


func _ready() -> void:
	QuestState.made_active.connect(add_entry)
	QuestState.made_finished.connect(add_entry)

func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()

func _on_mouse_entered(source: Control):
	subcontrol_mouse_entered.emit(source)

func _on_mouse_exited():
	subcontrol_mouse_exited.emit()

func _on_draw():
	tab_bar.size.x = tab_size_x
	tab_bar.position.x = 0.0
	if last_focused_entry:
		play_focus_sfx = false
		last_focused_entry.grab_focus()
		play_focus_sfx = true

func _on_quest_entry_focused(quest_entry: Control):
	last_focused_entry = quest_entry

func add_entry(quest_data: QuestData):
	var filter_view := ''
	match quest_data.status:
		QuestData.QuestStatus.ACTIVE:
			filter_view = 'active'
		QuestData.QuestStatus.FINISHED:
			filter_view = 'finished'
			var active_view: Control = tab.get_child(tabs['active']).get_child(0)
			for i in active_view.get_child_count():
				if (active_view.get_child(i) as QuestUiEntry).quest_data == quest_data:
					active_view.get_child(i).queue_free()
					break

	if not filter_view.is_empty():
		var quest_entry: Control = preload('uid://d0ndwgbbr3qcw').instantiate().init(quest_data)
		get_child(tabs[filter_view]).get_child(0).add_child(quest_entry)
		quest_entry.focus_entered.connect(_on_quest_entry_focused.bind(quest_entry))
