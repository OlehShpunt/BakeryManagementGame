class_name IngredientInteractiveArea extends Area2D

@onready var item : Ingredient = get_parent()

# Called when Ingredient enters InventoryCell or StorageCell areas
func _on_area_entered(area: CellArea) -> void:
	# Need to be careful here, because CellArea for inventory and storage might be different in nature
	if (item.recent_cell_area == null):  # To prevent accidental overridings, which will cause troubles
		print(">>>> entered, ", area)
		item.recent_cell_area = area

func _on_area_exited(area: CellArea) -> void:
	if (area == item.recent_cell_area):
		print(">>>> exited, ", area)
		item.recent_cell_area = null
