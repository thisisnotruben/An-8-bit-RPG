extends Node
class_name TargetService

@export var player: Character
@export var hud: HUD


func _ready():
	get_tree().get_nodes_in_group("character") \
		.map(func(c): c.on_selected.connect(on_character_selected))

func on_character_selected(character: Character):
	if character != player:
		if character == player.target:
			if can_hit(player) or can_shoot(player):
				return
			player.target = null
		else:
			player.target = character
		hud.target = character

static func can_hit(character: Character) -> bool:
	return character.fsm.can_melee() \
		and character.is_foe(character.hit_scan_melee.get_collider())

static func can_shoot(character : Character) -> bool:
	return character.fsm.can_shoot() \
		and character.is_foe(character.hit_scan_shoot.get_collider())
