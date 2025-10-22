extends Button
class_name HudButton

const drag_item := preload("res://src/ui/hud/hud_drag_icon.tscn")

@onready var label: Label = $margin_label/label
@onready var color_rect: ColorRect = $margin_color/colorRect
@onready var anim: AnimationPlayer = $anim

@export var player: Character = null
@export var item_icon: Texture = null: set = _on_set_icon
@export var quick_slot := false
var item_type := ItemDB.Type.INVALID: set = _on_set_item
var tween := get_tree().create_tween().bind_node(self)
var is_cooling_down := false

signal on_cooldown_started(_item_type: ItemDB.Type)


func _ready():
	tween.finished.connect(_on_tween_finished)

func _get_drag_data(_at_position: Vector2) -> Variant:
	if quick_slot and item_type != ItemDB.Type.INVALID:
		set_drag_preview(drag_item.instantiate().init(item_icon))
		return { "item_type": item_type, "slot": self, }
	return { }

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return quick_slot and data is Dictionary and data.has_all(["item_type", "slot",])

func _drop_data(_at_position: Vector2, data: Variant):
	if quick_slot:
		if item_type != ItemDB.Type.INVALID:
			data["slot"].clear()
			data["slot"]._on_set_item(item_type)
		_on_set_item(data["item_type"])

func _on_pressed():
	use()

func _on_tween_finished():
	is_cooling_down = false
	disabled = false
	color_rect.hide()

func _on_focus_entered():
	anim.play("focus")

func _on_focus_exited():
	anim.play("unfocus")

func use():
	if item_type != ItemDB.Type.INVALID:
		var data := ItemDB.get_item_type_data(item_type)
		if data.use:
			data.use_enter()
			if data.cooldown > 0:
				is_cooling_down = true
				disabled = true
				tween.tween_method(set_cooldown_text, data.cooldown, 0, data.cooldown)
				on_cooldown_started.emit(item_type)
				color_rect.show()
				var timer := get_tree().create_timer(data.cooldown, false, true)
				player.current_uses.set(item_type, timer)
				await timer.timeout
				player.current_uses.erase(item_type)

func check_cooldown(value: ItemDB.Type):
	if item_type != ItemDB.Type.INVALID and item_type == value:
		disabled = true
		var cooldown_sec := ItemDB.get_item_type_data(value).cooldown
		tween.tween_method(set_cooldown_text, cooldown_sec, 0, cooldown_sec)
		color_rect.show()

func _on_set_item(value: ItemDB.Type):
	item_type = value
	if item_type != ItemDB.Type.INVALID:
		_on_set_icon(ItemDB.get_item_type_data(value).icon)

func _on_set_icon(value: Texture):
	$icon.texture = value

func clear():
	item_type = ItemDB.Type.INVALID
	label.text = ""
	tween.stop()
	_on_tween_finished()

func set_cooldown_text(value: int):
	label.text = str(value)
