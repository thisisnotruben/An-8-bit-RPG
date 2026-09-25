class_name QuestObjective extends Resource

enum Type { KILL, COLLECT, }

## Used for UI objective tracker 
@export var type := Type.KILL

@export var amount := 0
@export var tag = ''
@export var display_name = ''

var current := 0
var finished := false 
