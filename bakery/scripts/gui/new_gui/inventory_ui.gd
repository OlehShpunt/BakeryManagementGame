extends Control


@onready var GRID_CONTAINER = $CanvasLayer/GridContainer


var capacity : int = 4
var inv_cell = preload("res://scenes/gui/new_gui/inventory_cell_ui.tscn")


func _ready() -> void:
	spawn_cells()


func _process(_delta: float) -> void:
	pass


func spawn_cells():
	if is_multiplayer_authority():
		for i in range(capacity):
			var cell = inv_cell.instantiate()
			cell.cell_id = i
			GRID_CONTAINER.add_child(cell)
