class_name QuestData extends Resource

enum QuestStatus{ NOT_STARTED, ACTIVE, COMPLETED, }

@export var quest_name := ''
@export_node_path('Character') var quest_giver := NodePath()
@export_node_path('Character') var quest_reciever := NodePath()
@export var next_quest: QuestData = null

@export_category('Dialogue')
@export_multiline var start_blurb := ''
@export_multiline var active_blurb := ''
@export_multiline var completed_blurb := ''
@export_multiline var delivered_blurb := ''

@export_category('Reward')
@export var reward_item := Item.Type.INVALID
@export var reward_gold: int = 0

var status := QuestStatus.NOT_STARTED


func enter():
	pass

func exit():
	pass

func check(_data: Dictionary):
	pass

func is_completable() -> bool:
	return false
