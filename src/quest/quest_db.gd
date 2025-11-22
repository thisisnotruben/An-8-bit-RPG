extends Node
class_name QuestDB

enum QuestStatus{ NOT_STARTED, ACTIVE, COMPLETED }

var quests := {}

class QuestData:
	var quest_name := ""
	var quest_start_blurb := ""
	var quest_active_blurb := ""
	var quest_completed_blurb := ""
	var quest_delivered_blurb := ""
	var status := QuestStatus.NOT_STARTED
	var active := false
	var completed := false
	var quest_giver := NodePath()
	var quest_reciever := NodePath()
	var reward_item := ItemDB.Type.INVALID
	var reward_gold: int = 0
	var next_quest: QuestData = null
	var _quest_enter := func(): pass
	var _quest_exit := func(): pass
	var _quest_check := func(_data: Dictionary): pass

	func enter():
		_quest_enter.call()

	func exit():
		_quest_exit.call()

	func check(data: Dictionary):
		_quest_check.call(data)

	func is_completable() -> bool:
		return false

static func check_quests(_payload: Dictionary) -> bool:
	return false

static func get_data(_payload: Dictionary) -> QuestData:
	return null
