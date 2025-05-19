class_name StorageCell_New extends CellBase

#var data_holder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


func get_cell_data():
	return get_parent().get_parent().get_parent().get_parent().get_storage_data_holder()
