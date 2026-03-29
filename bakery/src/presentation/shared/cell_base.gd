class_name CellBase
extends Panel

@export var _id: int
var _cell_state: CellState


func set_texture(item_texture: Texture2D) -> void:
	push_error("Not implemented in child class.")
