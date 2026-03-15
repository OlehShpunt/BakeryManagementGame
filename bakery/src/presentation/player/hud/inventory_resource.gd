class_name InventoryResource extends Resource

@export var num_of_cells : int = 4

# second value must be strings
@export var items = ["", "", "", ""]

func add_item(id : int, item : String) -> void:
	items[id] = item

func get_item(id : int):
	return items[id]

func remove_item(id : int):
	add_item(id, "")
