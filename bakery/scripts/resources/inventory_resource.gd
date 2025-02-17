class_name InventoryResource extends Resource

@export var num_of_cells : int = 4
#var converter : ItemFormConverter = preload("res://resources/gui/item_form_converter.tres")

# second value must be strings
@export var items = ["", "", "", ""]

func add_item(id : int, item : String) -> void:
	print("^ inventory res add_item() called")
	items[id] = item

func get_item(id : int):
	return items[id]

func remove_item(id : int):
	add_item(id, "")
