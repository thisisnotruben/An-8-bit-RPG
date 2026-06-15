extends TextureRect


func init(_texture: Texture2D) -> TextureRect:
	texture = _texture
	return self

func _ready():
	size = custom_minimum_size
