extends Node
class_name ItemBehavior

@onready var behavior: BTPlayer = $behavior
var current_cooldown: float = 0.0


func _ready():
	behavior.update(0.0)

func set_behavior_res(behavior_tree: BehaviorTree, character: Character):
	behavior.behavior_tree = behavior_tree
	behavior.blackboard.set_var("character_var", character)

func _on_behavior_updated(_status: int):
	pass # Replace with function body.

func serialize() -> Dictionary:
	return {}

func deserialize(_payload: Dictionary):
	pass
