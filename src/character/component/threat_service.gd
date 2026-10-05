class_name ThreatService extends Node

## Value in seconds
const THREAT_DECAY_THRESHOLD := 2.5

@onready var timer: Timer = $timer

var threats := {}
var last_threat: NodePath

signal on_no_threats
signal on_first_threat_added


func add_threat(aggressor: Character):
	if not aggressor:
		return
		
	var aggressor_path := aggressor.get_path()
	if threats.has(aggressor_path):
		return
		
	threats.set(aggressor_path, {'threat_dmg': 0, \
		'last_hit_time': Time.get_ticks_msec(), 'threat_decayed': false})
	if threats.size() == 1:
		timer.start(THREAT_DECAY_THRESHOLD)

func threat_changed(aggressor: Character, amount: int) -> Character:
	if not aggressor:
		return null
	
	var aggressor_path := aggressor.get_path()
	if not threats.has(aggressor_path):
		return null
	
	threats[aggressor_path]['last_hit_time'] = Time.get_ticks_msec()
	threats[aggressor_path]['threat_dmg'] += int(abs(amount))
	threats[aggressor_path]['threat_decayed'] = false
	
	if threats.size() == 1:
		last_threat = aggressor_path
		on_first_threat_added.emit()
		return aggressor
	return get_highest_threat()

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
	clear()

func filter_valid_aggressors():
	var queued_to_remove := []
	for aggressor_path: NodePath in threats:
		var aggressor := get_node_or_null(aggressor_path) as Character
		
		if not is_instance_valid(aggressor) \
		or aggressor.fsm.state == CharacterStates.Type.DEAD:
			queued_to_remove.append(aggressor_path)
			
	queued_to_remove.map(func(k): threats.erase(k))

func aggressor_remove(aggressor: Character) -> Character:
	threats.erase(aggressor.get_path())
	return get_highest_threat()

func get_highest_threat() -> Character:
	filter_valid_aggressors()
	if threats.is_empty():
		return null
	
	var highest_threat_dmg := -1
	var aggressor_path := NodePath()
	
	for path: NodePath in threats:
		if highest_threat_dmg == -1:
			highest_threat_dmg = threats[path]['threat_dmg']
			aggressor_path = path
		elif threats[path]['threat_dmg'] > highest_threat_dmg:
			aggressor_path = path
			
	last_threat = aggressor_path
	return get_node_or_null(aggressor_path) as Character

func clear():
	threats.clear()
	timer.stop()
	on_no_threats.emit()
