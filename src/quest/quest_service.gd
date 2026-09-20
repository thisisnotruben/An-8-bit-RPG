class_name QuestService extends Node

@export var quests: Array[QuestData] = []

func init():
	# make sure quests are loaded in order
	quests.sort_custom(func(a: QuestData, b: QuestData):
			return a.status < b.status)
	
	for quest in quests:
		if quest.dependent_on_quest \
		and quest.dependent_on_quest.status != QuestData.QuestStatus.FINISHED:
			continue
			
		for involved in quest.dialogue_whose_involved:
			var speaker = get_node_or_null(involved.speaker_node_path)
			if speaker is Character:
				speaker.set_dialogue(quest.dialogue, involved.cue_name, involved.alias)

static func check_quests(_payload: Dictionary) -> bool:
	return false    

static func get_data(_payload: Dictionary) -> QuestData:
	return null
