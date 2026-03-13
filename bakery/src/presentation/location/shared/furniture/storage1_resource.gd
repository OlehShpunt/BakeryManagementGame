class_name Storage1Resource extends Resource

@export var num_of_cells : int = 10

@export var items = ["", "", "", "", "", "", "", "", "", ""]

func add_item(id : int, item : String) -> void:
	print("^ storage1 res add_item() called")
	items[id] = item

func get_item(id : int):
	return items[id]

func remove_item(id : int):
	add_item(id, "")
