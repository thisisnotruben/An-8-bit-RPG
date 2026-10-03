class_name IdleRoam extends Resource

enum Type { NONE, ROAM, PATH_FOLLOW }
static var _tree: SceneTree

## Point to either: Area2D, Path2D
@export var node_path: NodePath
var node: Node2D
var type := Type.NONE

var recent_pos := Vector2.ZERO

## For 'ROAM'
var _roam_radius := 1.0
var _character: Character
## For 'PATH_FOLLOW'
var _path_follow_idx := 0
var _reversed := false


func init(character: Character, _node_path := NodePath()) -> IdleRoam:
	if not node_path and _node_path.is_empty():
		return self
	elif not _node_path.is_empty():
		node_path = _node_path
		
	_character = character
	_tree = _character.get_tree()
	_roam_radius = ((_character.get_node('sight/coll') as CollisionShape2D) \
		.shape as CircleShape2D).radius
	node = _character.get_node_or_null(node_path)
	
	if not node:
		printerr('Couldn\'t find node: [%s] for [%s]' % [node_path, _character.get_path()])
	elif node is Area2D:
		type = Type.ROAM
	elif node is Path2D:
		type = Type.PATH_FOLLOW
	else:
		printerr('Incompatible type: [%s]' % type_string(typeof(node)))
	return self
	
func get_pos() -> Vector2:
	var pos := Vector2.ZERO
	match type:
		Type.PATH_FOLLOW:
			var curve: Curve2D = (node as Path2D).curve
			pos = node.global_position + curve.get_point_position(_path_follow_idx)
			
			if _reversed:
				_path_follow_idx -= 1
				if _path_follow_idx == 0:
					_reversed = false
			else:
				_path_follow_idx += 1
				if _path_follow_idx == curve.point_count - 1:
					_reversed = true
					
		Type.ROAM:
			var theta : float = randf() * 2 * PI
			pos = _character.global_position \
				+ Vector2(cos(theta), sin(theta)) * sqrt(randf()) * _roam_radius
			
			var query := PhysicsPointQueryParameters2D.new()
			query.collide_with_areas = true
			query.collide_with_bodies = false
			query.position = pos
			
			# Check if still in bounds
			if _tree.root.get_world_2d().direct_space_state.intersect_point(query) \
			.filter(func(r): return node == r['collider']).is_empty():
				pos = Vector2.ZERO
				
	recent_pos = pos
	return pos
