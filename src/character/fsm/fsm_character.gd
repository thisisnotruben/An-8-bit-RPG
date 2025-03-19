extends Fsm
class_name FsmCharacter


func _set_state(_state_type) -> bool:
	if _curr["state"] != null:
		match _curr["state"].switch_type:
			CharacterState.SwitchType.DISABLED:
				return false
			CharacterState.SwitchType.AT_END:
				if _curr["state"].switch_type_status == CharacterState.SwitchTypeStatus.ACTIVE:
					return false
	return super._set_state(_state_type)

func can_melee() -> bool:
	return states.has(CharacterStates.Type.MELEE)

func can_shoot() -> bool:
	return states.has(CharacterStates.Type.SHOOT)
