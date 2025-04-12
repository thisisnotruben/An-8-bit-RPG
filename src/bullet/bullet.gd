extends Node2D
class_name Bullet

@onready var anim: AnimationPlayer = $anim
@onready var ray: RayCast2D = $ray

@export var anim_name := ""
@export_range(0.0, 50.0) var speed = 10.0

var damage: int = 0
var spawn_call: Callable = func(): pass
var from_character: Character = null
var hit := false


func _ready():
	spawn_call.call()

func spawn_shot(args := {}):
	var node: Node2D = null

	if args.has("character"):
		node = args["character"]
		from_character = node
		node.snd_shoot.play()
		damage = node.shoot_damage

		var exceptions := []
		if node.is_in_group("friendly"):
			exceptions = node.get_tree().get_nodes_in_group("friendly")
		elif node.is_in_group("foe"):
			exceptions = node.get_tree().get_nodes_in_group("foe")

		spawn_call = func():
			exceptions.map(func(e): ray.add_exception(e))
#			TODO
			#transform.origin = node.hit_scan_shoot.global_position
			#transform.basis = node.img.basis

		node.add_sibling(self)

func _physics_process(delta: float):
	if not hit:
		if ray.is_colliding():
			if anim.has_animation(anim_name):
				anim.play(anim_name)
			hit = true
			var hit_scan := ray.get_collider()
			if hit_scan is Character:
				hit_scan.health -= damage
				if from_character != null:
					hit_scan.aggro(from_character)
		else:
			pass
#			TODO: find locomotion
			#global_position += -transform.basis.z * speed * delta

func _on_timer_timeout():
	queue_free()
