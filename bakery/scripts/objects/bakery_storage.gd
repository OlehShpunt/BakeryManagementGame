class_name bakery_storage extends Node2D

@onready var GRID_CONTAINER = $StorageUI/GridContainer


var capacity : int = 8
var storage_cell = preload("res://scenes/gui/new_gui/bakery_storage_cell_ui.tscn")


func _ready() -> void:
	spawn_cells()


func _process(_delta: float) -> void:
	pass


func spawn_cells():
	if is_multiplayer_authority():
		for i in range(capacity):
			var cell = storage_cell.instantiate()
			cell.cell_id = i
			GRID_CONTAINER.add_child(cell)
