extends Node


func _ready() -> void:
	($quest_service as QuestService).init()
