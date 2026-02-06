class_name HudSlotSave extends Resource

@export var time_left: float
@export var path: NodePath


func serialize(hud_slot: HudButton) -> HudSlotSave:
	time_left = -1.0 # TODO: { 'time_left': player.current_uses[item_type].time_left \
	path = hud_slot.get_path()
	return self

func deserialize(tree: SceneTree):
	var hud_slot: HudButton = tree.current_scene.get_node_or_null(path)
	if hud_slot and time_left > 0.0:
		hud_slot._start_tween(time_left)
