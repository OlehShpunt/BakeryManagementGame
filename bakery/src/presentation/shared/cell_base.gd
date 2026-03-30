class_name CellBase
extends Panel

@warning_ignore("unused_private_class_variable")
@export var _id: int
@warning_ignore("unused_private_class_variable")
var _cell_state: CellState


@warning_ignore("unused_parameter")
func set_texture(item_texture: Texture2D) -> void:
	push_error("Not implemented in child class.")
