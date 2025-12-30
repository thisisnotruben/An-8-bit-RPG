@tool
class_name CharacterBuilder extends Resource

enum CharaterSideRoles { MERCHANT, TRAINER, DIALOGUE, }

@export var character_name := ''
@export var npc := true
@export var friendly := false
@export var character_roles: Array[CharaterSideRoles] = []
@export var gold: ModifierAmount = preload('uid://dvkkiqw5dqasq')

@export var hit_flags: HitFlags = preload('uid://bdowfnvtuwygf')
@export var stats: CharacterStats = preload('uid://dotidkyrhls6l')

@export_group('Items & Spells')
@export_subgroup('Npc')
@export var drops: Dictionary[int, Item.Type] = {} # int [0 - 100 range] (drop percent)
@export_subgroup('Player')
@export var spells: Array[Item.Type] = []
@export var inventory: Array[Item.Type] = []

@export_group('Behavior')
@export var npc_behavior: BehaviorTree = preload('uid://bn3ar0pqvknrx')
@export var player_behavior: BehaviorTree = preload('uid://bmm4llq2i8kce')

@export_group('Animation')
@export var anim_state_machine: AnimationNodeStateMachine
@export var anim_library: AnimationLibrary

@export_group('Audio')
@export var snd_idle: Array[AudioStream] = []
@export var snd_move: Array[AudioStream] = []
@export var snd_dead: Array[AudioStream] = []
@export var snd_melee: Array[AudioStream] = []
@export var snd_shoot: Array[AudioStream] = []
@export var snd_hurt: Array[AudioStream] = []

@export_group('Image')
@export var img_offset := Vector2(0.0, -3.0)
@export var coll_body: Shape2D = preload('uid://ccrqr6kge8p4w')
@export var coll_body_offset := Vector2(0.0, -4.0)


func init(character: Character):
	hit_flags.init(character, friendly, npc)
	stats.init(character)

	# Npc
	character.nav_agent.avoidance_enabled = npc
	(character.get_node('cam') as Camera2D).enabled = not npc
	character.behavior.behavior_tree = npc_behavior if npc else player_behavior

	character.behavior.blackboard.set_var('character_var', character)
	character.behavior.blackboard.set_var('health_var', character.health.current)
	character.behavior.blackboard.bind_var_to_property('health_var', character.health, 'current')

	# Animation
	character.anim_tree.tree_root = anim_state_machine
	for lib_name in character.anim.get_animation_library_list():
		character.anim.remove_animation_library(lib_name)
	character.anim.add_animation_library( \
		anim_library.resource_path.get_file().get_basename(), anim_library)

	# Audio
	var audio := {
		'fsm/idle': snd_idle,
		'fsm/move': snd_move,
		'fsm/dead': snd_dead,
		'fsm/melee': snd_melee,
		'fsm/shoot': snd_shoot,
		'fsm/hurt': snd_hurt,
	}

	for node_path in audio:
		(character.get_node(node_path) as CharacterState).quips = audio[node_path]

	# Image
	character.img.offset = img_offset
	var body: CollisionShape2D = character.get_node('body')
	body.shape = coll_body
	body.position = coll_body_offset
