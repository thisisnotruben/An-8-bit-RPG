extends GridContainer

var play_focus_sfx := false
var focused_slot: HudButton = null


func _ready():
	$vBox/grid.get_children().map(func(s): \
		s.focus_entered.connect(_on_slot_focus_entered.bind(s)))

func _on_slot_focus_entered(slot: HudButton):
	if play_focus_sfx: # TODO
		pass
	focused_slot = slot
	display(slot.item)

func _on_draw():
	play_focus_sfx = false
	$vBox/grid/slot1.grab_focus()
	play_focus_sfx = true

func display(item: Item):
	if item == null:
		return

	$vBox/header/icon.texture = item.icon
	$vBox/header/name.text = item.name
	$vBox/description.text = item.blurb

#	TODO
	$vBox/action/use.visible = true
	$vBox/action/drop.visible = true
