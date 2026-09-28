class_name ItemDropTable extends Resource

enum Type { ALWAYS, COMMON, UNCOMMON, RARE, EPIC, }

static var table := {
	Type.COMMON: randf_range(0.6, 0.75),
	Type.UNCOMMON: randf_range(0.2, 0.3),
	Type.RARE: randf_range(0.05, 0.1),
	Type.EPIC: randf_range(0.005, 0.02),
}

## A 0 means this is ignored
@export_range(0.0, 1.0, 0.01) var non_drop_pct := 0.4
@export var drops: Array[ItemDrop] = []


func get_drop() -> Item:
	var always_dropped_item: Item = null
	for drop in drops:
		if drop.weight_type == Type.ALWAYS:
			if always_dropped_item:
				printerr('Duplicate dropped type ALWAYS in drop table.')
			always_dropped_item = drop.item
			
	if always_dropped_item:
		return always_dropped_item
	
	if not is_zero_approx(non_drop_pct) and randf() <= non_drop_pct:
		return
	
	var total_weight := 0.0
	for drop in drops:
		total_weight += table[drop.weight_type]
	
	var roll := randf_range(0.0, total_weight)
	var cumulative := 0.0
	for drop in drops:
		if not drop.can_drop():
			continue
			
		cumulative += table[drop.weight_type]
		if roll <= cumulative:
			return drop.item
	return null
