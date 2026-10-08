@tool
class_name CharacterBuilder extends Resource

static var IMPORTING := false

enum CharaterSideRoles { MERCHANT, TRAINER, DIALOGUE, }

@export var character_name := ''
@export var npc := true
@export var friendly := false
@export var tags: Array[String] = []
@export var character_roles: Array[CharaterSideRoles] = []
@export var gold: ModifierAmount = preload('uid://dvkkiqw5dqasq')
@export var hit_flags: HitFlags = preload('uid://bdowfnvtuwygf')
@export var stats: CharacterStats = preload('uid://dotidkyrhls6l')

@export_category('Npc')
@export var npc_behavior: BehaviorTree = preload('uid://bn3ar0pqvknrx')
@export var respawn: CharacterRespawn = preload('uid://bsvw0x3p7x1eq')
@export var drops: ItemDropTable
@export var roam: IdleRoam = preload('uid://bst00ennl1vy0')
## if 'non_aggresive', then unit doesn't fight and flees when hit
@export var non_aggresive := false:
	set(value):
		non_aggresive = value
		pursuit_can_melee_check = not value
		pursuit_can_shoot_check = not value
		if not value:
			custom_melee_bt = null
			custom_shoot_bt = null
		
@export_group('BT tweaks')
@export var pursuit_can_shoot_check := true
@export var pursuit_can_melee_check := true

@export var dead_after_bt: BehaviorTree
@export var custom_shoot_bt: BehaviorTree
@export var custom_melee_bt: BehaviorTree

@export_category('Player')
@export var player_behavior: BehaviorTree = preload('uid://bmm4llq2i8kce')
@export var spells: Array[Item.Type] = []
@export var inventory: Array[Item.Type] = []

@export_category('Animation')
@export var anim_state_machine: AnimationNodeStateMachine
@export var anim_library: AnimationLibrary

@export_category('Audio')
@export var snd_idle: Array[AudioStream] = []
@export var snd_move: Array[AudioStream] = []
@export var snd_dead: Array[AudioStream] = []
@export var snd_melee: Array[AudioStream] = []
@export var snd_shoot: Array[AudioStream] = []
@export var snd_hurt: Array[AudioStream] = []

@export_category('Image')
@export var img_offset := Vector2(0.0, -3.0)
@export var coll_body: Shape2D = preload('uid://ccrqr6kge8p4w')
@export var coll_body_offset := Vector2(0.0, -4.0)


func _init():
	resource_local_to_scene = true

func init(character: Character):
	if IMPORTING:
		return
	elif not character.is_node_ready() and not Engine.is_editor_hint():
		await character.ready
	
	hit_flags.init(character, friendly, npc)
	stats.init(character)
	respawn.init(character.global_position)
	if not Engine.is_editor_hint():
		roam.init(character)
		
	# Npc
	character.nav_agent.avoidance_enabled = npc
	(character.get_node('cam') as Camera2D).enabled = not npc
	
	# Behavior
	character.behavior.behavior_tree = npc_behavior if npc else player_behavior
	character.behavior.blackboard.set_var(LimboVarLib.CHARACTER, character)
	character.behavior.blackboard.set_var(LimboVarLib.HEALTH, character.health.current)
	character.behavior.blackboard.bind_var_to_property(LimboVarLib.HEALTH, character.health, 'current')
	character.behavior.blackboard.set_var(LimboVarLib.NON_AGGRESSIVE, non_aggresive)
	_set_custom_behaviors(character)
	
	# Animation
	character.anim_tree.tree_root = anim_state_machine
	for lib_name in character.anim.get_animation_library_list():
		character.anim.remove_animation_library(lib_name)
	if anim_library != null:
		character.anim.add_animation_library( \
			anim_library.resource_path.get_file().get_basename(), anim_library)

	# Image
	character.img.offset = img_offset
	character.body.shape = coll_body
	character.body.position = coll_body_offset

func make_unique():
	gold = gold.duplicate_deep(DEEP_DUPLICATE_ALL)
	stats = stats.duplicate_deep(DEEP_DUPLICATE_ALL)
	respawn = respawn.duplicate_deep(DEEP_DUPLICATE_ALL)
	if drops:
		drops = drops.duplicate_deep(DEEP_DUPLICATE_ALL)
	roam = roam.duplicate_deep(DEEP_DUPLICATE_ALL)
	
func _set_custom_behaviors(character: Character):
	var rt := character.behavior.behavior_tree.get_root_task()
	for i in rt.get_child_count():
		var task := rt.get_child(i)
		match task.get_task_name():
			'dead' when dead_after_bt:
				var tree := BTSubtree.new()
				tree.subtree = dead_after_bt
				task.add_child(tree)
			'attack' when custom_melee_bt or custom_shoot_bt:
				for j in task.get_child_count():
					var logic := task.get_child(j)
					if logic.get_task_name() == 'logic':
						for k in logic.get_child_count():
							
							var subSubTask := logic.get_child(k) as BTSubtree
							if not subSubTask:
								continue
							
							match subSubTask.get_task_name():
								'shoot' when custom_shoot_bt:
									subSubTask.subtree = custom_shoot_bt
								'melee' when custom_melee_bt:
									subSubTask.subtree = custom_melee_bt
