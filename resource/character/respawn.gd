@tool
class_name CharacterRespawn extends Resource

@export var max_sec := 60.0
@export var min_sec := 90.0
@export var pos := Vector2.ZERO


func init(respawn_point: Vector2) -> CharacterRespawn:
	pos = respawn_point
	return self

## Get rand time between min & max in seconds.
func get_respawn_time() -> float:
	return randf_range(min_sec, max_sec)
