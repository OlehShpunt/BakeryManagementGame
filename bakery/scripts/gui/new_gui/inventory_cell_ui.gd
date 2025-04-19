extends Control


@onready var texture_rect : TextureRect = $Panel/CenterContainer/TextureRect


var cell_id = -1
var current_item_scene_path = path_holder.EMPTY


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(cell_id)
	on_current_item_changed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


## Updates the cell texture
func on_current_item_changed():
	var image_path = item_form_converter.get_image_path_from_scene(current_item_scene_path)
	var texture = item_form_converter.get_texture_from_image_path(image_path)
	texture_rect.set_texture(texture)
