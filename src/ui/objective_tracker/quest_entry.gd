extends FoldableContainer

@onready var quest_started: Label = $"margin/tabs/Started/blurb"
@onready var quest_active: Label = $"margin/tabs/Active/blurb"
@onready var quest_completed: Label = $"margin/tabs/Completed/blurb"
@onready var tab: TabContainer = $margin/tabs
const tabs := {"started": 0, "active": 1, "completed": 2}

var quest_data: QuestData = null


func init(value: QuestData) -> Control:
	quest_data = value
	return self

func _ready():
	if quest_data:
		quest_started.text = quest_data.start_blurb
		quest_active.text = quest_data.active_blurb
		quest_completed.text = quest_data.completed_blurb

func _on_draw():
	if quest_data:
		tab.get_tab_bar().set_tab_hidden(tabs["completed"],
			quest_data.status == QuestData.QuestStatus.ACTIVE)
