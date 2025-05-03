class_name StorageCell_New extends CellBase


@onready var bakery_data_instance = bakery_data.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	bakery_data_instance = bakery_data.new()


func get_cell_data():
	return bakery_data_instance
