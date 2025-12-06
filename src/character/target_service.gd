extends Node

@export var player: Character = null
@export var hud: HUD = null


func _ready():
	get_tree().get_nodes_in_group("character") \
		.map(func(c): c.on_selected.connect(on_character_selected))

func on_character_selected(character: Character):
	if character != player:
		if character == player.target:
			if player.can_hit() or player.can_shoot():
				return
			player.target = null
		else:
			player.target = character
		hud.target = character
