extends CharacterState
class_name CharacterStateSpell

enum SpellType {
	HEAL,
	FORTIFY,
	SPAWN,
	SPELL_HIT,
}

var spell_type := -1
var spell_callable: Callable = func(): return false


func init(args := {}) -> IState:
	super.init(args)
	return self
