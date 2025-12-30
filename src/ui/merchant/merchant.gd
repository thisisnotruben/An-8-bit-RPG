extends HBoxContainer

@onready var snd_nav := $snd_nav

@onready var player_item_icon: TextureRect = $player_item_detail/header/icon
@onready var player_item_name: Label = $player_item_detail/header/name
@onready var player_item_blurb: Label = $player_item_detail/description
@onready var player_item_worth: Label = $player_item_detail/worth
@onready var player_item_slots: Array[Node] = $player/grid.get_children()
@onready var sell_bttn: BaseButton = $player_item_detail/sell

@onready var merchant_item_icon: TextureRect = $merchant_item_detail/header/icon
@onready var merchant_item_name: Label = $merchant_item_detail/header/name
@onready var merchant_item_blurb: Label = $merchant_item_detail/description
@onready var merchant_item_worth: Label = $merchant_item_detail/worth
@onready var merchant_item_slots: Array[Node] = $merchant/grid.get_children()

var play_focus_sfx := false
var player_focused_slot: HudButton = null
var merchant_focused_slot: HudButton = null
var player: Character = null

signal subcontrol_focused
signal subcontrol_mouse_entered(source)
signal subcontrol_mouse_exited


func _ready():
	for slot in (player_item_slots + merchant_item_slots):
		slot.focus_entered.connect(_on_slot_focus_entered.bind(slot))
		slot.pressed.connect(_on_slot_focus_entered.bind(slot))

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

	var is_player_slot := player_item_slots.has(slot)
	if is_player_slot:
		player_focused_slot = slot
	else:
		merchant_focused_slot = slot
	display(slot.item_type, is_player_slot)

func _on_draw():
	play_focus_sfx = false
	player_item_slots[0].grab_focus()
	play_focus_sfx = true

func display(item_type: Item.Type, is_player_slot: bool):
	if item_type != Item.Type.INVALID:
		var data := ItemDB.get_item(item_type)
		if is_player_slot:
			player_item_icon.texture = data.icon
			player_item_name.text = data.item_name
			player_item_blurb.text = data.blurb
			player_item_worth.text = "+ %d" % data.worth
		else:
			merchant_item_icon.texture = data.icon
			merchant_item_name.text = data.item_name
			merchant_item_blurb.text = data.blurb
			merchant_item_worth.text = "+ %d" % data.worth

func clear(is_player: bool):
	if is_player:
		player_focused_slot = null
		player_item_icon.texture = null
		player_item_name.text = ""
		player_item_blurb.text = ""
		player_item_worth.text = ""
		sell_bttn.hide()
	else:
		merchant_focused_slot = null
		merchant_item_icon.texture = null
		merchant_item_name.text = ""
		merchant_item_blurb.text = ""
		merchant_item_worth.text = ""

func _on_sell_pressed():
	$snd_sell.play()
	player.inventory_modify(player_focused_slot.item_type, false)
	player.gold += ItemDB.get_item(player_focused_slot.item_type).worth
	clear(true)

func _on_buy_pressed():
	var item : Item = ItemDB.get_item(merchant_focused_slot.item_type)
	assert(item is Item)
	if player.gold < item.worth:
		$snd_cant_afford.play()
	elif is_full(true):
		$snd_inventory_full.play()
	else:
		$snd_buy.play()
		add_item(merchant_focused_slot.item_type, true)
		player.inventory_modify(merchant_focused_slot.item_type, true)
		player.gold -= item.worth

func is_full(player_slots: bool) -> bool:
	return (player_item_slots if player_slots else merchant_item_slots) \
		.filter(func(s): return s.item_type != Item.Type.INVALID).is_empty()

func add_item(item_type: Item.Type, player_slots: bool) -> bool:
	var useable_slots := (player_item_slots if player_slots else merchant_item_slots) \
		.filter(func(s): return s.item_type != Item.Type.INVALID)
	if useable_slots.is_empty():
		return false
	useable_slots[0].item_type = item_type
	return true
