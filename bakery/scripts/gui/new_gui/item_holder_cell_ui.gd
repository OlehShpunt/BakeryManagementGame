class_name item_holder_cell_ui 
extends CellBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


func get_cell_data():
	return get_parent().get_parent().get_parent().get_parent().get_storage_data_holder()


func set_cell_size(multiplicator : float) -> void:
	super.set_cell_size(multiplicator)


func get_grid():
	get_parent()
