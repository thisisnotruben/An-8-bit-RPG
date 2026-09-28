class_name QuestService extends Node

@export var quests: Array[QuestData] = []
static var QUESTS: Array[QuestData] = []

var player: Character


func init(_player: Character):
	QuestState.made_finished.connect(quest_finished_cleanup)
	
	player = _player
	_player.inventory_added.connect(_on_player_inventory_changed)
	_player.spell_added.connect(_on_player_inventory_changed)
	
	for character: Character in get_tree().get_nodes_in_group('character'):
		if character != _player:
			character.died.connect(_on_character_killed)
		
	# make sure quests are loaded in order
	quests.sort_custom(func(a: QuestData, b: QuestData): return a.status < b.status)
	QUESTS = quests
	
	for quest: QuestData in quests:
		if quest.dependent_on_quest \
		and quest.dependent_on_quest.status != QuestData.QuestStatus.FINISHED:
			continue
			
		for involved in quest.dialogue_whose_involved:
			var speaker = get_node_or_null(involved.speaker_node_path)
			if speaker is Character:
				speaker.set_dialogue(quest.dialogue, involved.cue_name, involved.alias, quest)

func _on_character_killed(killed: Character):
	if not killed.unit.npc or not killed.threat.last_threat:
		return # check if killed is npc by negation
	
	var aggressor := get_node_or_null(killed.threat.last_threat) as Character
	if not aggressor or aggressor.unit.npc:
		return # check if killed by player by negation
	
	for quest in _get_active_quests():
		var is_quest_completed := true
		for objective in quest.objectives:
			if objective.type == QuestObjective.Type.KILL \
			and killed.unit.tags.has(objective.tag):
				objective.current += 1
				objective.completed = objective.current >= objective.amount
			
		if is_quest_completed:
			quest.status = QuestData.QuestStatus.COMPLETED

func _on_player_inventory_changed(payload: Dictionary):
	if not payload.has_all(['type', 'add']):
		return
		
	for quest in _get_active_quests():
		var is_quest_completed := true
		
		for objective in quest.objectives:
			if objective.type == QuestObjective.Type.COLLECT \
			and objective.item and objective.item.type == payload['type']:
				if payload['add']:
					objective.current += 1
				else:
					objective.current -= 1
				objective.completed = objective.current >= objective.amount
			is_quest_completed = is_quest_completed and objective.completed
			
		if is_quest_completed:
			quest.status = QuestData.QuestStatus.COMPLETED

func _get_active_quests() -> Array[QuestData]:
	return QUESTS.filter(func(q): return q.status == QuestData.QuestStatus.ACTIVE)

static func get_data(id: QuestData.Id) -> QuestData:
	var quest := QUESTS.filter(func(q): return q.id == id)
	return null if quest.is_empty() else quest[0]

func quest_finished_cleanup(quest: QuestData):
	if not player:
		return
	
	for objective in quest.objectives:
		if objective.type == QuestObjective.Type.COLLECT:
			for i in range(objective.amount):
				player.inventory_modify(objective.item.type, false)
