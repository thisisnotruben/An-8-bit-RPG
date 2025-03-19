extends IState
class_name CharacterState

enum SwitchType { IMMEDIATE, AT_END, DISABLED }
enum SwitchTypeStatus { INACTIVE, ACTIVE, FINISHED }

@export var enabled := true
@export var quips: Array[AudioStream] = []
@export_range(0.0, 1.0) var quip_play_chance := 1.0

var character: Character = null
var switch_type := SwitchType.IMMEDIATE
var switch_type_status := SwitchTypeStatus.INACTIVE
var type := -1


func init(args := {}) -> IState:
	character = args["character"]
	return self

func play_quip(override := false, idx: int = -1):
	if not quips.is_empty() and (override or \
	(not character.snd.playing and quip_play_chance >= randf())):
		if idx == -1:
			character.snd.stream = quips.pick_random()
		else:
			character.snd.stream = quips[idx]
		character.snd.play()
