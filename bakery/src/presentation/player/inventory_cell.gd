class_name InventoryCell
extends Panel

@export var _id: int

@onready var border: Panel = $Border

signal button_pressed(cell_id: int)

var id: int:
	set(id):
		_id = id
	get:
		return _id


func _ready() -> void:
	hide_border()


func _on_texture_button_pressed() -> void:
	button_pressed.emit(_id)


func hide_border() -> void:
	border.hide()


func show_border() -> void:
	border.show()
