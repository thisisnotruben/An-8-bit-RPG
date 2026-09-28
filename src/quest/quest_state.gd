extends Node

signal made_active(quest: QuestData)
signal made_finished(quest: QuestData)

## placeholder for 'orc_caverns.tres' for testing
var focused_quest: QuestData = preload('uid://btdnqwwx1am2k')

var _status_rep := {
	QuestData.QuestStatus.FINISHED: 'finished',
	QuestData.QuestStatus.NOT_STARTED: 'not_started',
	QuestData.QuestStatus.ACTIVE: 'active',
	QuestData.QuestStatus.COMPLETED: 'completed'
}

var status: String:
	set(value):
		match value:
			'finished':
				focused_quest.status = QuestData.QuestStatus.FINISHED
				made_finished.emit(focused_quest)
			'active':
				focused_quest.status = QuestData.QuestStatus.ACTIVE
				made_active.emit(focused_quest)
			'completed':
				focused_quest.status = QuestData.QuestStatus.COMPLETED
			_:
				printerr('Wrong value of [%s] when setting quest status in dialogue' % value)
				
		status = value
	get:
		return _status_rep[focused_quest.status]
