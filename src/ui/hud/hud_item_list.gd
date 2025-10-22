extends GridContainer
class_name UIItemHandler

const item_scene := preload("res://src/item/item.tscn")

@onready var snd: AudioStreamPlayer = $snd
@onready var item_icon: TextureRect = $vBox_item_detail/header/icon
@onready var item_name: Label = $vBox_item_detail/header/name
@onready var item_blurb: Label = $vBox_item_detail/description
@onready var use_bttn: BaseButton = $vBox_item_detail/action/use
@onready var drop_bttn: BaseButton = $vBox_item_detail/action/drop
@onready var slots: Array = $vBox/grid.get_children()

var play_focus_sfx := false
var focused_slot: HudButton = null
var player: Character = null : set = _on_set_player


func _ready():
	var quick_slots := get_tree().get_nodes_in_group("quick_slot")
	for slot in slots:
		slot.focus_entered.connect(_on_slot_focus_entered.bind(slot))
		slot.pressed.connect(_on_slot_focus_entered.bind(slot))
		slot.on_cooldown_started.connect(_on_check_cooldown)
		for quick_slot in quick_slots:
			slot.on_cooldown_started.connect(quick_slot.check_cooldown)

func _on_slot_focus_entered(slot: HudButton):
	if play_focus_sfx:
		snd.play()
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
		use_bttn.visible = data.use and not is_cooling_down
		drop_bttn.visible = data.drop

func clear():
	item_icon.texture = null
	item_name.text = ""
	item_blurb.text = ""
	use_bttn.hide()
	drop_bttn.hide()

func is_full() -> bool:
	return slots.filter(func(s): return s.item_type != ItemDB.Type.INVALID).is_empty()

func add_item(item_type: ItemDB.Type) -> bool:
	var useable_slots = slots.filter(func(s): return s.item_type != ItemDB.Type.INVALID)
	if useable_slots.is_empty():
		return false
	useable_slots[0].item_type = item_type
	return true

func _on_check_cooldown(item_type: ItemDB.Type):
	for slot in slots:
		if slot.item_type != ItemDB.Type.INVALID and not slot.is_cooling_down:
			slot.check_cooldown(item_type)

func _on_use_pressed():
	focused_slot.use()

func _on_drop_pressed():
	if player != null:
		var item: Item = item_scene.instantiate().init({"type": focused_slot.item_type})
		player.add_sibling(item)
		item.global_position = player.global_position
	focused_slot.clear()
	clear()

func _on_set_player(value: Character):
	player = value
	slots.map(func(s): s.player = value)
