class_name AbilityPlayer extends Node

@onready var player: BTPlayer = $player
var ability: Ability
var target: Character


func init(_ability: Ability, _target: Character) -> AbilityPlayer:
	ability = _ability
	target = _target
	return self

func _ready():
	player.blackboard.set_var('character_var', target)
	player.behavior_tree = ability.behavior

func enter():
	player.active = true
