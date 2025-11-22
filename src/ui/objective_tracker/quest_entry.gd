extends FoldableContainer

@onready var quest_started: Label = $"margin/tabs/Quest Started/blurb"
@onready var quest_active: Label = $"margin/tabs/Quest Active/blurb"
@onready var quest_completed: Label = $"margin/tabs/Quest Completed/blurb"
@onready var tab: TabContainer = $tabs
const tabs := {"started": 0, "active": 1, "completed": 2}

var quest_data: QuestDB.QuestData = null


func init(value: QuestDB.QuestData) -> Control:
	quest_data = value
	return self

func _ready():
	if quest_data != null:
		quest_started.text = quest_data.quest_start_blurb
		quest_active.text = quest_data.quest_active_blurb
		quest_completed.text = quest_data.quest_completed_blurb

func _on_focus_entered():
	folded = false

func _on_focus_exited():
	folded = true

func _on_folding_changed(is_folded: bool):
	if not is_folded and quest_data != null:
		tab.get_tab_bar().set_tab_hidden(tabs["completed"], \
			quest_data.status == QuestDB.QuestStatus.ACTIVE)
