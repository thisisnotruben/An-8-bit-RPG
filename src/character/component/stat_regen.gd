extends Node
class_name StatRegenComponent

@onready var timer := $timer

@export var stat_component: StatComponent = null
@export var regen_amount: int = 1


func _on_timer_timeout():
	stat_component.current += regen_amount

func set_timer(sec: float):
	if not is_equal_approx(timer.wait_time, sec):
		timer.start(sec)

func start():
	timer.start()

func stop():
	timer.stop()
