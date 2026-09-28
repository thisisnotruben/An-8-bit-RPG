extends ItemDropPredicate


func can_drop() -> bool:
	var quest := QuestService.get_data(QuestData.Id.BLUE_GOO)
	return quest and quest.status == QuestData.QuestStatus.ACTIVE
