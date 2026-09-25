extends FoldableContainer

@onready var description: RichTextLabel = $margin/scroll/description

var quest_data: QuestData = null


func init(value: QuestData) -> Control:
	quest_data = value
	return self

func _on_draw() -> void:
	set_description()
	
func set_description():
	if quest_data:
		title = quest_data.quest_name
		
		var des_builder := PackedStringArray()
		for objective: QuestObjective in quest_data.objectives:
			
			var type := '- Kill'
			match objective.type:
				QuestObjective.Type.COLLECT:
					type = 'Collect'
			
			des_builder.append('%s %d/%d %s\n' \
				% [type, objective.current, objective.amount, objective.display_name])
			
		des_builder.append('\n%s' % quest_data.description)
		description.text = ''.join(des_builder)
