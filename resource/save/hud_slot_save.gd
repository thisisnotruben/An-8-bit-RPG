class_name HudSlotSave extends Resource

@export var time_left: float
@export var path: NodePath


func serialize(hud_slot: HudButton) -> HudSlotSave:
	if hud_slot.tween and hud_slot.is_cooling_down:
		time_left = ItemDB.get_item(hud_slot.item_type).cooldown - hud_slot.tween.get_total_elapsed_time()
		path = hud_slot.get_path()
		if time_left > 0.0:
			return self
	return null

func deserialize(tree: SceneTree):
	var hud_slot: HudButton = tree.current_scene.get_node_or_null(path)
	if hud_slot:
		hud_slot._start_tween(time_left)
