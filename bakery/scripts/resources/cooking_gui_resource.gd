class_name CookingGuiResource extends Resource

@export var num_of_cells : int = 8

var recipe_manager : RecipeManager = RecipeManager.new()

# 8th is the result cell
@export var items = ["", "", "", "", "", "", "", ""]

var empty_cell_value : String = ""

var result_cell_id = items.size() - 1

func add_item(id : int, item : String) -> void:
	print("^ cook gui res add_item() called")
	items[id] = item
	check_for_recipies()

func get_item(id : int):
	return items[id]

func remove_item(id : int):
	if id == result_cell_id:
		items[result_cell_id] = ""
		clean_items_array()
	else:
		# Regular remove functionality
		add_item(id, "")

func check_for_recipies():
	var items_copy = items.duplicate()
	# removing the recipe result cell
	items_copy.resize(7)
	print("JSON is recipy valid?: ", recipe_manager.get_recipe_result(items_copy))

## Adds cooking result to last cell
func add_to_result(result : String):
	items[7] = result

## Assigns all items array elements to ""
func clean_items_array():
	for i in range(items.size()): 
		print("^ clearing ", i)
		items[i] = empty_cell_value
	for item in items:
		print("^ item ", item)
