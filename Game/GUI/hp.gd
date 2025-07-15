extends TextureRect



@export var full_texture: Texture
@export var empty_texture: Texture

func set_filled(filled: bool):
	texture = full_texture if filled else empty_texture
