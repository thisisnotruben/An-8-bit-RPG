class_name ItemDrop extends Resource

@export var weight_type := ItemDropTable.Type.COMMON
@export var item: Item

var _drop_predicate: ItemDropPredicate
@export var drop_predicate: GDScript:
	set(value):
		drop_predicate = value
		_drop_predicate = value.new()


func can_drop() -> bool:
	return _drop_predicate.can_drop()
