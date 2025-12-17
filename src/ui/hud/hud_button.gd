extends Button
class_name HudButton

enum Type{ PLAYER, MERCHANT }

const drag_item := preload("res://src/ui/hud/hud_drag_icon.tscn")

@onready var label: Label = $margin_label/label
@onready var color_rect: ColorRect = $margin_color/colorRect
@onready var anim: AnimationPlayer = $anim

@export var player: Character = null
@export var item_icon: Texture = null: set = _on_set_icon
@export var quick_slot := false
@export var type := Type.PLAYER: set = _on_set_type
var item_type := Item.Type.INVALID: set = _on_set_item
var is_cooling_down := false
var tween: Tween = null

signal on_cooldown_started(_item_type: Item.Type)


func _get_drag_data(_at_position: Vector2) -> Variant:
	if quick_slot and item_type != Item.Type.INVALID:
		set_drag_preview(drag_item.instantiate().init(item_icon))
		return { "item_type": item_type, "slot": self, }
	return { }

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return quick_slot and data is Dictionary and data.has_all(["item_type", "slot",])

func _drop_data(_at_position: Vector2, data: Variant):
	if quick_slot:
		if item_type != Item.Type.INVALID:
			data["slot"].clear()
			data["slot"]._on_set_item(item_type)
		_on_set_item(data["item_type"])

func _on_pressed():
	use()

func _on_tween_finished():
	is_cooling_down = false
	disabled = false
	tween = null
	color_rect.hide()

func _on_focus_entered():
	anim.play("focus")

func _on_focus_exited():
	anim.play("unfocus")

func use():
	if item_type != Item.Type.INVALID:
		var item := ItemDB.get_item_type_data(item_type)
		if item.behavior:
			player.spawn_item_behavior(item.behavior)
			if item.behavior_cooldown > 0.0:
				_start_tween(item.behavior_cooldown)
				on_cooldown_started.emit(item_type)

func check_cooldown(value: Item.Type):
	if type == Type.PLAYER and not is_cooling_down \
	and item_type != Item.Type.INVALID and item_type == value:
		var item := ItemDB.get_item_type_data(value)
		if item.behavior and item.behavior_cooldown > 0.0:
			_start_tween(item.behavior_cooldown)

func _start_tween(tween_time_sec: float):
	is_cooling_down = true
	disabled = true
	tween = get_tree().create_tween()
	tween.finished.connect(_on_tween_finished)
	tween.tween_method(set_cooldown_text, tween_time_sec, 0, tween_time_sec)
	color_rect.show()

func _on_set_item(value: Item.Type):
	item_type = value
	if item_type != Item.Type.INVALID:
		_on_set_icon(ItemDB.get_item_type_data(value).icon)

func _on_set_icon(value: Texture):
	$icon.texture = value

func _on_set_type(value: Type):
	type = value
	if value == Type.MERCHANT:
		remove_from_group("serializable")
		pressed.disconnect(_on_pressed)
	else:
		if not is_in_group("serializable"):
			add_to_group("serializable")
		if not pressed.is_connected(_on_pressed):
			pressed.connect(_on_pressed)

func clear():
	item_type = Item.Type.INVALID
	label.text = ""
	if is_instance_valid(tween) and tween is Tween:
		tween.stop()
	_on_tween_finished()

func set_cooldown_text(value: int):
	label.text = str(value)

func serialize() -> Dictionary:
	return {}
	# TODO
	#return { "time_left": player.current_uses[item_type].time_left \
		#if player.current_uses.has(item_type) else -1.0 } \
	#if is_cooling_down else {}

func deserialize(payload: Dictionary):
	if payload.has("time_left") and payload["time_left"] > 0.0:
		_start_tween(payload["time_left"])
