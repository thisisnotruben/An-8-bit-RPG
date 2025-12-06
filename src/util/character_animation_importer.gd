extends Node
class_name Importer

const FRAME_SIZE := Vector2(32.0, 32.0)
const FRAME_DIRECTION_SEQ := ["down_right", "down_left", "right_up", "left_up"]
const FACING := [Vector2(0.1, 0.2), Vector2(-0.2, 0.2), Vector2(0.1, -0.2), Vector2(-0.2, -0.2)]
const LOOPABLE_ANIM := ["move", "idle", "walk"]


func import_anim_file(file_path: String, anim_base_name: String,
anim_name: String,  frame_length_mili: int, frame_size := FRAME_SIZE):
	var resource_file_path := "res://resource/animation/%s.tres" % anim_base_name
	var anim_library := AnimationLibrary.new()
	if ResourceLoader.exists(resource_file_path):
		anim_library = ResourceLoader.load(resource_file_path)

	var texture: Texture2D = load(file_path)
	var v_frames := texture.get_height() / frame_size.y

	for i in range(v_frames):
		anim_library.add_animation(
			"%s_%s" % [anim_name, FRAME_DIRECTION_SEQ[i]] if v_frames > 1 else anim_name,
			create_anim(file_path, frame_length_mili, i, anim_name, frame_size))

	ResourceSaver.save(anim_library, resource_file_path)

func create_anim(file_path: String, frame_length_mili: int,
frame_seq: int, anim_name: String, frame_size: Vector2) -> Animation:
	var animation := Animation.new()
	var texture: Texture2D = load(file_path)
	var frames := texture.get_size() / frame_size
	animation.length = float(frame_length_mili) * float(frames.x) * 0.001
	if LOOPABLE_ANIM.has(anim_name):
		animation.loop_mode = Animation.LOOP_LINEAR

	var img_track_index := animation.add_track(Animation.TYPE_VALUE, 0)
	animation.track_set_path(img_track_index, "img:texture")
	animation.track_insert_key(img_track_index, 0.0, texture)
	animation.value_track_set_update_mode(0, Animation.UpdateMode.UPDATE_DISCRETE)

	var hframes_track_index := animation.add_track(Animation.TYPE_VALUE, 1)
	animation.track_set_path(hframes_track_index, "img:hframes")
	animation.track_insert_key(hframes_track_index, 0.0, frames.x)
	animation.value_track_set_update_mode(1, Animation.UpdateMode.UPDATE_DISCRETE)

	var vframes_track_index := animation.add_track(Animation.TYPE_VALUE, 2)
	animation.track_set_path(vframes_track_index, "img:vframes")
	animation.track_insert_key(vframes_track_index, 0.0, frames.y)
	animation.value_track_set_update_mode(2, Animation.UpdateMode.UPDATE_DISCRETE)

	var frame_track_index := animation.add_track(Animation.TYPE_VALUE, 3)
	animation.track_set_path(frame_track_index, "img:frame")
	animation.track_insert_key(frame_track_index, 0.0, frame_seq * frames.x)
	animation.track_insert_key(frame_track_index, animation.length, (frame_seq + 1) * frames.x - 1)
	animation.value_track_set_update_mode(0, Animation.UpdateMode.UPDATE_CONTINUOUS)

	return animation

func create_state_machine(anim_base_name: String, anim_library_path: String, anim_name_templates: Array):
	var state_machine := AnimationNodeStateMachine.new()
	var anim_library := AnimationLibrary.new()
	if ResourceLoader.exists(anim_library_path):
		anim_library = ResourceLoader.load(anim_library_path)
	else:
		print_debug("create_state_machine: unable to load anim library [%s]" \
			% anim_library_path)
		return

	var node_placement := Vector2(384.0, 64.0 * 3.0)
	var anim_list := anim_library.get_animation_list()
	var anims_without_facing := anim_list.filter(
		func(a): return anim_name_templates.has(a))
	var anims_with_facing := anim_name_templates.filter(
		func(a): return not anims_without_facing.has(a))

	for anim_name in anims_without_facing:
		var node = AnimationNodeAnimation.new()
		node.animation = "%s/%s" % [anim_base_name, anim_name]
		state_machine.add_node(anim_name, node, node_placement)
		node_placement.y += 64.0

	for anim_name in anims_with_facing:
		var node := AnimationNodeBlendSpace2D.new()
		node.blend_mode = AnimationNodeBlendSpace2D.BLEND_MODE_DISCRETE
		for i in range(FRAME_DIRECTION_SEQ.size()):
			var anim_name_face := "%s_%s" % [anim_name, FRAME_DIRECTION_SEQ[i]]
			if anim_library.has_animation(anim_name_face):
				var anim_node := AnimationNodeAnimation.new()
				anim_node.animation = "%s/%s" % [anim_base_name, anim_name_face]
				node.add_blend_point(anim_node, FACING[i])
			else:
				print_debug("create_state_machine: [%s] doesn't have [%s]" \
					% [anim_library_path, anim_name_face])
		state_machine.add_node(anim_name, node, node_placement)
		node_placement.y += 64.0

	_add_transition(state_machine, "Start", "idle", "")
	for anim_name_type in anim_name_templates:
		match anim_name_type:
			"idle":
				_add_transition(state_machine, anim_name_type, "walk", "fsm.state == 1")
				_add_transition(state_machine, anim_name_type, "attack", "[2, 3].has(fsm.state)")
				_add_transition(state_machine, anim_name_type, "die", "fsm.state == 4")
				_add_transition(state_machine, anim_name_type, "dmg", "fsm.state == 6")
				_add_transition(state_machine, anim_name_type, "jump", "fsm.state == 8")
				_add_transition(state_machine, anim_name_type, "work", "fsm.state == 9")
			"walk":
				_add_transition(state_machine, anim_name_type, "idle", "fsm.state == 0")
				_add_transition(state_machine, anim_name_type, "attack", "[2, 3].has(fsm.state)")
				_add_transition(state_machine, anim_name_type, "die", "fsm.state == 4")
				_add_transition(state_machine, anim_name_type, "dmg", "fsm.state == 6")
			"attack":
				_add_transition(state_machine, anim_name_type, "idle", "fsm.state == 0", true)
				_add_transition(state_machine, anim_name_type, "walk", "fsm.state == 1", true)
				_add_transition(state_machine, anim_name_type, "die", "fsm.state == 4")
				_add_transition(state_machine, anim_name_type, "dmg", "fsm.state == 6")
			"dmg":
				_add_transition(state_machine, anim_name_type, "idle", "fsm.state == 0", true)
				_add_transition(state_machine, anim_name_type, "walk", "fsm.state == 1", true)
				_add_transition(state_machine, anim_name_type, "attack", "[2, 3].has(fsm.state)", true)
				_add_transition(state_machine, anim_name_type, "die", "fsm.state == 4", true)
			"jump":
				_add_transition(state_machine, anim_name_type, "idle", "fsm.state == 0", true)
				_add_transition(state_machine, anim_name_type, "die", "fsm.state == 4")
			"move":
				_add_transition(state_machine, anim_name_type, "idle", "fsm.state == 0")
				_add_transition(state_machine, anim_name_type, "die", "fsm.state == 4")
				_add_transition(state_machine, anim_name_type, "dmg", "fsm.state == 6")

	ResourceSaver.save(state_machine, \
		"res://resource/animation_state_machine/%s_state_machine.tres" \
		% anim_library_path.get_file().get_basename())

func _add_transition(state_machine: AnimationNodeStateMachine,
from: String, to: String, expression: String, at_end := false):
	if state_machine.has_node(from) and state_machine.has_node(to):
		var transition := AnimationNodeStateMachineTransition.new()
		transition.advance_mode = AnimationNodeStateMachineTransition.ADVANCE_MODE_AUTO
		if at_end:
			transition.switch_mode = AnimationNodeStateMachineTransition.SWITCH_MODE_AT_END
		transition.advance_expression = expression
		state_machine.add_transition(from, to, transition)

func make_character_icon(file_path: String, character_name: String, frame_size := FRAME_SIZE):
	if not ResourceLoader.exists(file_path):
		print("make_character_icon: [%s] doesn't exist." % file_path)
		return

	var image := Image.load_from_file(file_path)
	image.crop(int(frame_size.x), int(frame_size.y))
	image.save_png("res://tiled/tileset/character/%s.png" % character_name)
