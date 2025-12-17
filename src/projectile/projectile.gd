extends Node2D
class_name Projectile

@onready var fsm: Fsm = $fsm
@onready var timer: Timer = $timer
@onready var dodge_sight: Area2D = $dodge_sight
@onready var hit_box: Area2D = $hit_box
@onready var snd: AudioStreamPlayer2D = $snd

@export var game_hit_flags: GameHitFlags:
	set(value):
		if not is_node_ready():
			await ready
		game_hit_flags = value
		assert(value != null)
		value.set_flags(self)

@export var strategy: ProjectileStrategy:
	set(value):
		if not is_node_ready():
			await ready

		strategy = value
		assert(value != null)
		timer.wait_time = strategy.timeout_sec
		for state_node in fsm.get_children():
			if state_node.type == value.move_strategy.type:
				state_node.set("speed", value.move_strategy.get("speed"))
				state_node.set("curve", value.move_strategy.get("curve"))
				state_node.set("until_type", value.move_strategy.get("until_type"))
				state_node.set("ease_type", value.move_strategy.get("ease_type"))
				state_node.set("transition_type", value.move_strategy.get("transition_type"))
				break

var from_character: Character = null
var direction := Vector2.ZERO
var seek_pos := Vector2.ZERO


func init(args := {}) -> Projectile:
	from_character = args["character"]
	direction = args["direction"]
	seek_pos = args["seek_pos"]
	return self

func _ready():
	var fsm_args := {}
	for state_node in fsm.get_children():
		fsm_args[state_node.type] = state_node
	fsm.init(fsm_args)

func _physics_process(delta: float):
	fsm.physics_process(delta)

func enter():
	fsm.state = strategy.move_strategy.type
	timer.start()

func exit():
	fsm.state = ProjectileMoveState.Type.STOPPED

func _on_timer_timeout():
	exit()
	queue_free()

func _on_hit_box_body_entered(body: Node2D):
	if from_character.is_foe(body):
		(body as Character).health.modify(strategy.damage)
		if not strategy.snd_hit_sfx.is_empty():
			snd.stream = strategy.snd_hit_sfx.pick_random()
			snd.play()

func _on_dodge_sight_body_entered(other_npc: Node2D):
	if from_character.is_foe(other_npc):
		(other_npc as Character).notify_projectile_incoming(self)
