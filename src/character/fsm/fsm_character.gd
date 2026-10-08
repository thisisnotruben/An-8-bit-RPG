class_name FsmCharacter extends Fsm


func _set_state(_state_type):
	if _curr['state']:
		match _curr['state'].switch_type:
			CharacterState.SwitchType.DISABLED:
				return false
			CharacterState.SwitchType.AT_END \
			when _curr['state'].switch_type_status == CharacterState.SwitchTypeStatus.ACTIVE:
				return false
	super._set_state(_state_type)
	return true

func can_melee() -> bool:
	return states.has(CharacterStates.Type.MELEE)

func can_shoot() -> bool:
	return states.has(CharacterStates.Type.SHOOT)

func get_switch_type() -> CharacterState.SwitchType:
	return _curr['state'].switch_type

func get_switch_status() -> CharacterState.SwitchTypeStatus:
	return _curr['state'].switch_type_status
