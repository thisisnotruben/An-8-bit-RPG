extends Control

var quest_entry_scene := preload("res://src/ui/objective_tracker/quest_entry.tscn")

var play_focus_sfx := false
var last_focused_entry: Control = null

signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited

@onready var tab_bar: TabBar = $tabs.get_tab_bar()
@onready var tab_size_x: float = $tabs.custom_minimum_size.x / 2.0
var tabs := {"active": 0, "completed": 1}


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
	var filter_view := ""
	match quest_data.status:
		QuestData.QuestStatus.ACTIVE:
			filter_view = "active"
		QuestData.QuestStatus.COMPLETED:
			filter_view = "completed"
			var active_view: Control = get_child(tabs["active"]).get_child(0)
			for i in active_view.get_child_count():
				if active_view.get_child(i).quest_data == quest_data:
					active_view.get_child(i).queue_free()
					break

	if not filter_view.is_empty():
		var quest_entry: Control = quest_entry_scene.instantiate().init(quest_data)
		get_child(tabs[filter_view]).get_child(0).add_child(quest_entry)
		quest_entry.focus_entered.connect(_on_quest_entry_focused)
