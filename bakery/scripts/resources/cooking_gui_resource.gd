class_name CookingGuiResource extends Resource

@export var num_of_cells : int = 9

@export var items = ["", "", "", "", "", "", "", "", ""]

func add_item(id : int, item : String) -> void:
	items[id] = item

func get_item(id : int):
	return items[id]

func remove_item(id : int):
	add_item(id, "")
