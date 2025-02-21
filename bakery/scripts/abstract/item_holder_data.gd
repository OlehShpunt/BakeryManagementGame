class_name ItemHolderData extends Node

var item_array = []

func _ready() -> void:
	resize_item_array(item_array, 15)

func get_item(index) -> String:
	return item_array[index]

func save_to(index : int, item : String):
	if (item_array[index] == "" or item_array[index] == null):
		push_warning("Overriding the value of item_array[", index, "] (", item_array[index], ") with new value ", item)
	item_array[index] = item

func empty_index(index):
	item_array[index] = ""

## Resizes the array and fills it with empty Strings
func resize_item_array(array, new_size, _todo = false):
	array.resize(new_size)
	array.fill("")
	#TODO: allow dynamic resizing without overwriting ALL values (hint: add 3rd bool param (default false), which if true, needs the method to loop through the array, and replace null values with empty Strings). 
