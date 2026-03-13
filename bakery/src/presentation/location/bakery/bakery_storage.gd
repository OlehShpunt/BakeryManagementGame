class_name bakery_storage extends Node2D

@onready var GRID_CONTAINER = $StorageUI/CanvasLayer/GridContainer
@onready var STORAGE_UI = $StorageUI
@onready var CANVAS_LAYER = $StorageUI/CanvasLayer
@onready var storage_data_holder = bakery_data.new()

@export var ID : int

@export var display_sprite = true

@export var capacity : int = 12
var storage_cell = preload("res://scenes/gui/new_gui/bakery_storage_cell_ui.tscn")

@export var grid_columns: int = 6

func _ready() -> void:
	
	# Initializing the storage data holder instance
	storage_data_holder.ID = self.ID
	storage_data_holder._ready()
	
	GRID_CONTAINER.columns = grid_columns
	spawn_cells()
	
	if not display_sprite:
		set_sprite_texture(null)
	


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
	# The check below is needed to prevent this bakery storage from using
	# a new bakery data holder, if it already registered in 
	# client_ui_data. Otherwise, a new instance would be used
	# for this storage, and the old data holder in client_ui_data
	# would be overwritten, so the items would disappear when player
	# leaves and re-enters the scene.
	var returned_val = client_ui_data.is_data_holder_registered(ID)
	
	if returned_val is not int:  # If is not ERR_DOES_NOT_EXIST, then it holdss the registered data_holder
		# It means the returned_val is the data_holder that needs to be used
		storage_data_holder = returned_val
		return storage_data_holder
	else:
		print("&&& is int, so new bakery storage instance is passed")
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


func set_sprite_texture(texture: Texture2D):
	$StaticBody2D/Sprite2D.texture = texture
