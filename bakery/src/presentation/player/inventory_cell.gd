class_name InventoryCell
extends CellBase

@onready var border: Panel = $Border
@onready var texture: TextureRect = $TextureRect

signal button_pressed(cell_id: int)

var id: int:
	set(id):
		_id = id
	get:
		return _id

var cell_state: CellState:
	set(state):
		_cell_state = state
		_cell_state.item_updated.connect(_on_item_updated)
	get():
		return _cell_state


func _ready() -> void:
	hide_border()
	set_texture(null)


func _on_texture_button_pressed() -> void:
	button_pressed.emit(_id)


func hide_border() -> void:
	border.hide()


func show_border() -> void:
	border.show()


func _on_item_updated(item: Item) -> void:
	if (item):
		set_texture(item.texture)
	else:
		set_texture(null)


func set_texture(item_texture: Texture2D) -> void:
	print("setting texture to ", item_texture)
	texture.texture = item_texture
