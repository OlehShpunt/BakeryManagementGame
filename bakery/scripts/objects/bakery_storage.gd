class_name bakery_storage extends Node2D

@onready var GRID_CONTAINER = $StorageUI/CanvasLayer/GridContainer
@onready var storage_data_holder = bakery_data.new()

@export var ID : int


var capacity : int = 12
var storage_cell = preload("res://scenes/gui/new_gui/bakery_storage_cell_ui.tscn")


func _ready() -> void:
	
	# Initializing the storage data holder instance
	storage_data_holder.ID = self.ID
	storage_data_holder._ready()
	
	spawn_cells()
#	hide_storage()


func _process(_delta: float) -> void:
	pass


func spawn_cells():
	if is_multiplayer_authority():
		for i in range(capacity):
			var cell = storage_cell.instantiate()
			cell.cell_id = i
			cell.cell_data = storage_data_holder
			#cell.parent_container = self
			GRID_CONTAINER.add_child(cell)
		hide_storage()


func get_storage_data_holder():
	return storage_data_holder


func show_storage():
	GRID_CONTAINER.show()


func hide_storage():
	GRID_CONTAINER.hide()


func _on_interactable_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player") and body.get_multiplayer_authority() == get_multiplayer_authority():
		print("entered, with mult auth: ", body.get_multiplayer_authority())
		show_storage()


func _on_interactable_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player") and body.get_multiplayer_authority() == get_multiplayer_authority():
		print("exited, with mult auth: ", body.get_multiplayer_authority())
		hide_storage()
