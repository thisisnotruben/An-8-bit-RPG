extends Control

@export var player: Character = null
@export var target: Character = null : set = _on_set_target

@export var inventory_icon: Texture = null
@export var merchant_icon: Texture = null
@export var trainer_icon: Texture = null
@export var dialogue_icon: Texture = null
@export var many_hats_icon: Texture = null
@export var target_status_name_padding: int = 2

@onready var interact_panel: Control = $bg_margin/vBox/center/panel

@onready var player_health: AtlasTexture = $status_margin/player_health.get("texture_progress")
@onready var player_mana: AtlasTexture = $status_margin/player_health/mana.get("texture_progress")
@onready var player_ability: AtlasTexture = $status_margin/player_health/ability.get("texture_progress")

@onready var target_health: AtlasTexture = $status_margin/target_health.get("texture_progress")
@onready var target_mana: AtlasTexture = $status_margin/target_health/mana.get("texture_progress")
@onready var target_ability: AtlasTexture = $status_margin/target_health/ability.get("texture_progress")
@onready var target_name_label: Label = $bg_margin/target_status_bar/margin/HBoxContainer/label
@onready var target_slot: HudButton = $bg_margin/target_status_bar/margin/HBoxContainer/slot

@onready var target_health_node: Control = $status_margin/target_health
@onready var target_status_bar: Control = $bg_margin/target_status_bar

@onready var tab: TabContainer = $bg_margin/vBox/center/panel/content_margin/tabs
const tabs := {"inventory": 0, "spell_book": 1, "dialogue": 2}


func _ready():
	var tab_order := [inventory_icon, trainer_icon, dialogue_icon]
	for i in tab_order.size():
		tab.set_tab_icon(i, tab_order[i])
		tab.set_tab_title(i, "")
	target_status_bar.visibility_changed.connect(func(): \
		target_health_node.visible = target_status_bar.visible)
	if player != null:
		player.health_changed.connect(_on_set_player_health)
		player.mana_changed.connect(_on_set_player_mana)
		player.ability_changed.connect(_on_set_player_ability)

func _on_set_target(value: Character):
	if target != null and value != target:
		value.health_changed.disconnect(_on_set_target_health)
		value.mana_changed.disconnect(_on_set_target_mana)
		value.ability_changed.disconnect(_on_set_target_ability)

	target = value
	target_status_bar.visible = value != null
	if value != null:

		var show_slot := not value.character_roles.is_empty()
		target_slot.visible = show_slot
		target_name_label.text = value.character_name if show_slot \
		else " ".repeat(target_status_name_padding) + value.character_name
		if show_slot:
			if value.character_roles.size() == 1:
				match value.character_roles[0]:
					Character.CharaterSideRoles.MERCHANT:
						target_slot.item_icon = merchant_icon
					Character.CharaterSideRoles.TRAINER:
						target_slot.item_icon = trainer_icon
					Character.CharaterSideRoles.DIALOGUE:
						target_slot.item_icon = dialogue_icon
			else:
				target_slot.item_icon = many_hats_icon

		_on_set_target_health(value.health, value.health_max)
		_on_set_target_mana(value.mana, value.mana_max)
		_on_set_target_ability(value.ability, value.ability_max)

		value.health_changed.connect(_on_set_target_health)
		value.mana_changed.connect(_on_set_target_mana)
		value.ability_changed.connect(_on_set_target_ability)

func _on_set_target_health(value: int, value_max: int):
	target_health.region.position.x = \
		_get_pct(value, value_max) * int(target_health.region.size.x)

func _on_set_target_mana(value: int, value_max: int):
	target_mana.region.position.x = \
		_get_pct(value, value_max) * int(target_mana.region.size.x)

func _on_set_target_ability(value: int, value_max: int):
	target_ability.region.position.x = \
		_get_pct(value, value_max) * int(target_ability.region.size.x)

func _on_set_player_health(value: int, value_max: int):
	player_health.region.position.x = \
		_get_pct(value, value_max) * int(player_health.region.size.x)

func _on_set_player_mana(value: int, value_max: int):
	player_mana.region.position.x = \
		_get_pct(value, value_max) * int(player_mana.region.size.x)

func _on_set_player_ability(value: int, value_max: int):
	player_ability.region.position.x = \
		_get_pct(value, value_max) * int(player_ability.region.size.x)

func _get_pct(value: int, value_max: int) -> int:
	return ceili(float(value) / float(value_max) * 10.0)

func _on_inventory_spell_book_pressed():
	var is_hud_panel_visible := not interact_panel.visible
	interact_panel.visible = is_hud_panel_visible
	if player != null:
		player.set_player_move_hud_menu_pause.emit(is_hud_panel_visible)

func _on_menu_pressed():
	var cancel_event = InputEventAction.new()
	cancel_event.action = "ui_cancel"
	cancel_event.pressed = true
	Input.parse_input_event(cancel_event)

func _on_interact_panel_exit_pressed():
	interact_panel.hide()

func _on_dialogue_accept_pressed():
	print("TODO: _on_dialogue_accept_pressed")

func _on_dialogue_decline_pressed():
	print("TODO: _on_dialogue_decline_pressed")
