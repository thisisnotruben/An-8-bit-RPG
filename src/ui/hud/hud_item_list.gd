extends GridContainer
class_name UIItemHandler

enum Type { PLAYER, MERCHANT }

const item_scene := preload("res://src/item/item.tscn")

@onready var snd_nav: AudioStreamPlayer = $snd_nav
@onready var snd_drop: AudioStreamPlayer = $snd_drop
@onready var snd_learn: AudioStreamPlayer = $snd_learn
@onready var item_icon: TextureRect = $vBox_item_detail/header/icon
@onready var item_name: Label = $vBox_item_detail/header/name
@onready var item_blurb: Label = $vBox_item_detail/description
@onready var use_bttn: BaseButton = $vBox_item_detail/action/use
@onready var drop_bttn: BaseButton = $vBox_item_detail/action/drop
@onready var learn_bttn: BaseButton = $vBox_item_detail/action/learn

@onready var slots: Array[Node] = $vBox/grid.get_children()

var play_focus_sfx := false
var focused_slot: HudButton = null
var player: Character = null : set = _on_set_player
@export var type := Type.PLAYER

signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited


func _ready():
	var quick_slots := get_tree().get_nodes_in_group("quick_slot")
	for slot in slots:
		slot.focus_entered.connect(_on_slot_focus_entered.bind(slot))
		slot.pressed.connect(_on_slot_focus_entered.bind(slot))
		if type == Type.PLAYER:
			slot.on_cooldown_started.connect(_on_check_cooldown)
			for quick_slot in quick_slots:
				slot.on_cooldown_started.connect(quick_slot.check_cooldown)
		else:
			slot.type = HudButton.Type.MERCHANT
	if type == Type.MERCHANT:
		$vBox/label.text = "Trainer"

func _on_focus_entered():
	if play_focus_sfx:
		subcontrol_focused.emit()

func _on_mouse_entered(source: Control):
	subcontrol_mouse_entered.emit(source)

func _on_mouse_exited():
	subcontrol_mouse_exited.emit()

func _on_slot_focus_entered(slot: HudButton):
	if play_focus_sfx:
		snd_nav.play()
	focused_slot = slot
	display(slot.item_type, slot.is_cooling_down)

func _on_draw():
	play_focus_sfx = false
	slots[0].grab_focus()
	play_focus_sfx = true

func display(item_type: ItemDB.Type, is_cooling_down: bool):
	if item_type != ItemDB.Type.INVALID:
		var data := ItemDB.get_item_type_data(item_type)
		item_icon.texture = data.icon
		item_name.text = data.item_name
		item_blurb.text = data.blurb

		var is_player_view := type == Type.PLAYER
		use_bttn.visible = is_player_view and data.use and not is_cooling_down
		drop_bttn.visible = is_player_view and data.drop
		learn_bttn.visible = not is_player_view

func clear():
	item_icon.texture = null
	item_name.text = ""
	item_blurb.text = ""
	use_bttn.hide()
	drop_bttn.hide()
	learn_bttn.hide()

func is_full() -> bool:
	return slots.filter(func(s): return s.item_type != ItemDB.Type.INVALID).is_empty()

func add_item(data: Dictionary) -> bool:
	if data["add"]:
		var useable_slots = slots.filter(func(s): return s.item_type != ItemDB.Type.INVALID)
		if useable_slots.is_empty():
			return false
		useable_slots[0].item_type = data["type"]
	else:
		for slot in slots:
			if slot.item_type == data["type"]:
				slot.clear()
				break
	return true

func _on_check_cooldown(item_type: ItemDB.Type):
	for slot in slots:
		if slot.item_type != ItemDB.Type.INVALID and not slot.is_cooling_down:
			slot.check_cooldown(item_type)

func _on_use_pressed():
	focused_slot.use()

func _on_drop_pressed():
	if player != null:
		snd_drop.play()
		var item: Item = item_scene.instantiate().init({"type": focused_slot.item_type})
		player.add_sibling(item)
		item.global_position = player.global_position
	focused_slot.clear()
	clear()

func _on_learn_pressed():
	snd_learn.play()
	player.inventory_add({"type": focused_slot.item_type, "add": true, "spell": true})
	player.gold -= ItemDB.get_item_type_data(focused_slot.item_type).worth

func _on_set_player(value: Character):
	player = value
	if type == Type.PLAYER:
		slots.map(func(s): s.player = value)
