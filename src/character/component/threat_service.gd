class_name ThreatService extends Node

## Value in seconds
const THREAT_DECAY_THRESHOLD := 2.5

@onready var timer: Timer = $timer

var threats := {}
var last_threat: NodePath

signal on_no_threats


func add_threat(aggressor: Character):
	var aggressor_path := aggressor.get_path()
	if threats.has(aggressor_path):
		return
		
	threats.set(aggressor_path, {'threat_dmg': 0, \
		'last_hit_time': Time.get_ticks_msec(), 'threat_decayed': false})
	if threats.size() == 1:
		timer.start(THREAT_DECAY_THRESHOLD)

func threat_changed(aggressor: Character, amount: int):
	var aggressor_path := aggressor.get_path()
	if not threats.has(aggressor_path):
		return null
	
	threats[aggressor_path]['last_hit_time'] = Time.get_ticks_msec()
	threats[aggressor_path]['threat_dmg'] += int(abs(amount))
	threats[aggressor_path]['threat_decayed'] = false
	
	if threats.size() == 1:
		last_threat = aggressor_path
		return aggressor
	else:
		var highest_threat_dmg: int = threats[aggressor_path]['threat_dmg']
		filter_valid_aggressors()
		for path: NodePath in threats:
			if threats[path]['threat_dmg'] > highest_threat_dmg:
				aggressor_path = path
		last_threat = aggressor_path
		return get_node(aggressor_path) as Character

func _on_timer_timeout() -> void:
	filter_valid_aggressors()
	var queued_to_remove := []
	for path: NodePath in threats:
		var threshold := THREAT_DECAY_THRESHOLD
		if threats[path]['threat_decayed']:
			threshold *= 2
			
		if threshold >= Time.get_ticks_msec() - threats[path]['last_hit_time']:
			queued_to_remove.append(path)
		
	queued_to_remove.map(func(k): threats.erase(k))
	if threats.is_empty():
		timer.stop()
		on_no_threats.emit()

func filter_valid_aggressors():
	var queued_to_remove := []
	for aggressor_path: NodePath in threats:
		var aggressor := get_node_or_null(aggressor_path) as Character
		
		if not is_instance_valid(aggressor) \
		or aggressor.fsm.state == CharacterStates.Type.DEAD:
			queued_to_remove.append(aggressor_path)
			
	queued_to_remove.map(func(k): threats.erase(k))
