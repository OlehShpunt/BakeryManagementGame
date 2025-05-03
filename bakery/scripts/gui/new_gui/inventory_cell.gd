class_name InventoryCell_New extends CellBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


func get_cell_data():
	return local_player_data
