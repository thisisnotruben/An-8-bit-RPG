class_name StatRegenComponent extends Node

@onready var timer := $timer

@export var character: Character
@export var stat_component: StatComponent = null
@export var regen_amount: float


func _on_timer_timeout():
	if regen_amount:
		stat_component.current += int(regen_amount)

func set_timer(sec: float):
	if not is_equal_approx(timer.wait_time, sec):
		timer.start(sec)

func start():
	timer.start()

func stop():
	timer.stop()
