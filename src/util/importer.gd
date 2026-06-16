extends Node


var anim_importer := Importer.new()
@export var spritesheet_libs: Array[CharacterSpriteSheetLib] = []

func _ready():
	#get_unique_anim_type_names()
	make_import_library(true)
	make_state_machines()
	make_character_icons()

func make_import_library(new_file:= false):
	var dir_access := DirAccess.open(Importer.ANIM_DIR)
	for lib in spritesheet_libs:
		for entry: CharacterSpriteSheetEntry in lib.lib:
			if new_file:
				dir_access.remove(entry.name + '.tres')
			for spritesheet: CharacterSpriteSheet in entry.spritesheet:
				anim_importer.import_anim_file(spritesheet.img, entry.name,
					spritesheet.name, int(spritesheet.time), entry.frame_size)

func make_state_machines():
	for lib in spritesheet_libs:
		for entry: CharacterSpriteSheetEntry in lib.lib:
			var file_path := Importer.ANIM_DIR + entry.name + '.tres'
			var anim_template_names := []
			for spritesheet: CharacterSpriteSheet in entry.spritesheet:
				anim_template_names.append(spritesheet.name)
			anim_importer.create_state_machine(entry.name, file_path, anim_template_names)

func get_unique_anim_type_names():
	var unique_values := {}
	for lib in spritesheet_libs:
		for entry: CharacterSpriteSheetEntry in lib:
			for spritesheet: CharacterSpriteSheet in entry.spritesheet:
				unique_values.set(spritesheet.name, null)
	print(unique_values.keys())

func make_character_icons():
	for lib in spritesheet_libs:
		for entry: CharacterSpriteSheetEntry in lib.lib:
			var idle_tex: Texture2D
			for spritesheet: CharacterSpriteSheet in entry.spritesheet:
				if spritesheet.name == 'idle':
					idle_tex = spritesheet.img
					break
			if idle_tex:
				var image := idle_tex.get_image()
				image.crop(int(entry.frame_size.x), int(entry.frame_size.y))
				image.save_png('res://tiled/tileset/character/%s.png' % entry.name)
			else:
				print('make_character_icons: [%s] has no [idle] anim.' % entry.name)
