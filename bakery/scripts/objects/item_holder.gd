class_name ItemHolder extends StaticBody2D

@export var item_texture : Texture2D
@onready var item_sprite : Sprite2D = $Item

func _ready() -> void:
	item_sprite.set_texture(item_texture)
