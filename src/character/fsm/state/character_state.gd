class_name CharacterState extends IState

enum SwitchType { IMMEDIATE, AT_END, DISABLED }
enum SwitchTypeStatus { INACTIVE, ACTIVE, FINISHED }

@export var enabled := true

var character: Character = null
var switch_type := SwitchType.IMMEDIATE
var switch_type_status := SwitchTypeStatus.INACTIVE
var type := -1
var blackboard := {}


func init(args := {}) -> IState:
	character = args['character']
	return self

func apply_animation(input_dir: Vector2):
	if input_dir.length() > 0.0:
		var a_t := 'parameters/%s/blend_position'
		var anim_direction := input_dir.normalized()
		['dmg', 'idle', 'walk', 'attack', 'idle_start', 'hurt'].filter(func(s): \
			return character.anim_tree.get(a_t % s) != null) \
			.map(func(s): character.anim_tree[a_t % s] = anim_direction)
