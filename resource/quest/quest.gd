class_name QuestData extends Resource

enum QuestStatus { FINISHED, NOT_STARTED, ACTIVE, COMPLETED }

@export var quest_name := ''
@export var dependent_on_quest: QuestData

@export_category('Dialogue')
@export var dialogue: DialogueResource
@export var dialogue_whose_involved: Array[InvoldedInQuestDialogue] = []

@export_category('Objectives')
@export var objectives: Array[QuestObjective] = []

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
