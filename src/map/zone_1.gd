extends Node


func _ready() -> void:
	var found_player := false
	for character: Character in get_tree().get_nodes_in_group('character'):
		if character.unit.npc:
			continue
		if found_player:
			printerr('More than one player in scene.')
			break
		found_player = true
		
		$target_service.player = character
		$CanvasLayer/hud.player = character
		$CanvasLayer/game.player = character
