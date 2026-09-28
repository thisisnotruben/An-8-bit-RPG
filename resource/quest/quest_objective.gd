class_name QuestObjective extends Resource

enum Type { KILL, COLLECT, }

## Used for UI objective tracker 
@export var type := Type.KILL
@export var amount := 0

@export_group('Kill type')
@export var tag := ''
@export var display_name := ''

@export_group('Collect type')
@export var item: Item 

var current := 0
var completed := false 
