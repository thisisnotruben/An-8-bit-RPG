extends Node

# placeholder for 'orc_caverns.tres' for testing
var focused_quest: QuestData = preload('uid://btdnqwwx1am2k')

var _status_rep := {
	QuestData.QuestStatus.FINISHED: 'finished',
	QuestData.QuestStatus.NOT_STARTED: 'not_started',
	QuestData.QuestStatus.ACTIVE: 'active',
	QuestData.QuestStatus.COMPLETED: 'completed'
}

var status: String:
	set(value):
		var _status := QuestData.QuestStatus.NOT_STARTED
		match value:
			'finished':
				_status = QuestData.QuestStatus.FINISHED
			'active':
				_status = QuestData.QuestStatus.ACTIVE
			'completed':
				_status = QuestData.QuestStatus.COMPLETED
			_:
				printerr('Wrong value of [%s] when setting quest status in dialogue' % value)
				
		status = value
		focused_quest.status = _status
	get:
		return _status_rep[focused_quest.status]
