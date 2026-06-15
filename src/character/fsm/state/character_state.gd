class_name CharacterState extends IState

enum SwitchType { IMMEDIATE, AT_END, DISABLED }
enum SwitchTypeStatus { INACTIVE, ACTIVE, FINISHED }

@export var enabled := true

var character: Character = null
var switch_type := SwitchType.IMMEDIATE
var switch_type_status := SwitchTypeStatus.INACTIVE
var type := -1
var blackboard := {}


func init(args := {}) -> IState:
	character = args['character']
	return self
