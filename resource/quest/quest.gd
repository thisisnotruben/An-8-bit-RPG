class_name QuestData extends Resource

enum Id {
	NOT_SET,
	BLUE_GOO,
	ORC_CAVERNS,
}

enum QuestStatus { FINISHED, NOT_STARTED, ACTIVE, COMPLETED }

@export var id := Id.NOT_SET
@export var quest_name := ''
@export var dependent_on_quest: QuestData

@export_category('Objectives')
@export_multiline() var description = ''
@export var objectives: Array[QuestObjective] = []

@export_category('Dialogue')
@export var dialogue: DialogueResource
@export var dialogue_whose_involved: Array[InvoldedInQuestDialogue] = []

@export_category('Reward')
@export var reward_item := Item.Type.INVALID
@export var reward_gold: int = 0

var status := QuestStatus.NOT_STARTED
