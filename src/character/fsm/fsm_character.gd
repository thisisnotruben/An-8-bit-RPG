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
	# TODO: need a better way to figure out what can melee
	return states.has(CharacterStates.Type.MELEE)

func can_shoot() -> bool:
	# TODO: need a better way to figure out what can shoot
	return states.has(CharacterStates.Type.SHOOT)
