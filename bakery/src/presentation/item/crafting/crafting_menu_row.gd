class_name CraftingMenuRow
extends Control
## NOTE: If cost_price is -10, it means that this item is not in player inventory, so show NotInInventory panel

@onready var item1_name_label: Label = $HBoxContainer/Item1/PanelContainer/Panel/VBoxContainer/ItemName
@onready var item1_texture_rect: TextureRect = $HBoxContainer/Item1/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var item1_cost_label: Label = $HBoxContainer/Item1/PanelContainer/Panel/VBoxContainer/Cost
@onready var item1_not_in_inventory_panel: Panel = $HBoxContainer/Item1/NotInInventory

@onready var item2_name_label: Label = $HBoxContainer/Item2/PanelContainer/Panel/VBoxContainer/ItemName
@onready var item2_texture_rect: TextureRect = $HBoxContainer/Item2/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var item2_cost_label: Label = $HBoxContainer/Item2/PanelContainer/Panel/VBoxContainer/Cost
@onready var item2_not_in_inventory_panel: Panel = $HBoxContainer/Item2/NotInInventory

@onready var item3_name_label: Label = $HBoxContainer/Item3/PanelContainer/Panel/VBoxContainer/ItemName
@onready var item3_texture_rect: TextureRect = $HBoxContainer/Item3/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var item3_cost_label: Label = $HBoxContainer/Item3/PanelContainer/Panel/VBoxContainer/Cost
@onready var item3_not_in_inventory_panel: Panel = $HBoxContainer/Item3/NotInInventory

@onready var item4_name_label: Label = $HBoxContainer/Item4/PanelContainer/Panel/VBoxContainer/ItemName
@onready var item4_texture_rect: TextureRect = $HBoxContainer/Item4/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var item4_cost_label: Label = $HBoxContainer/Item4/PanelContainer/Panel/VBoxContainer/Cost
@onready var item4_not_in_inventory_panel: Panel = $HBoxContainer/Item4/NotInInventory

@onready var item5_name_label: Label = $HBoxContainer/Item5/PanelContainer/Panel/VBoxContainer/ItemName
@onready var item5_texture_rect: TextureRect = $HBoxContainer/Item5/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var item5_cost_label: Label = $HBoxContainer/Item5/PanelContainer/Panel/VBoxContainer/Cost
@onready var item5_not_in_inventory_panel: Panel = $HBoxContainer/Item5/NotInInventory

@onready var item6_name_label: Label = $HBoxContainer/Item6/PanelContainer/Panel/VBoxContainer/ItemName
@onready var item6_texture_rect: TextureRect = $HBoxContainer/Item6/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var item6_cost_label: Label = $HBoxContainer/Item6/PanelContainer/Panel/VBoxContainer/Cost
@onready var item6_not_in_inventory_panel: Panel = $HBoxContainer/Item6/NotInInventory

@onready var item7_name_label: Label = $HBoxContainer/Item7/PanelContainer/Panel/VBoxContainer/ItemName
@onready var item7_texture_rect: TextureRect = $HBoxContainer/Item7/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var item7_cost_label: Label = $HBoxContainer/Item7/PanelContainer/Panel/VBoxContainer/Cost
@onready var item7_not_in_inventory_panel: Panel = $HBoxContainer/Item7/NotInInventory

@onready var result_item_name_label: Label = $HBoxContainer/ResultItem/PanelContainer/Panel/VBoxContainer/ItemName
@onready var result_item_texture_rect: TextureRect = $HBoxContainer/ResultItem/PanelContainer/Panel/VBoxContainer/TextureRect
@onready var result_item_cost_label: Label = $HBoxContainer/ResultItem/PanelContainer/Panel/VBoxContainer/Cost
@onready var result_item_button: Button = $HBoxContainer/ResultItem/Button

static var crafting_menu_row_packed_scene: PackedScene = preload("res://src/presentation/item/crafting/crafting_menu_row.tscn")

var _item1: Item:
	get:
		return _item1
	set(value):
		_item1 = value
		item1_name_label.text = value.name
		item1_texture_rect.texture = value.texture
		item1_cost_label.text = str(value.cost_price)
		if value.cost_price == -10:
			item1_not_in_inventory_panel.visible = true
			item1_cost_label.text = ""
		else:
			item1_not_in_inventory_panel.visible = false

var _item2: Item:
	get:
		return _item2
	set(value):
		_item2 = value
		item2_name_label.text = value.name
		item2_texture_rect.texture = value.texture
		item2_cost_label.text = str(value.cost_price)
		if value.cost_price == -10:
			item2_not_in_inventory_panel.visible = true
			item2_cost_label.text = ""
		else:
			item2_not_in_inventory_panel.visible = false

var _item3: Item:
	get:
		return _item3
	set(value):
		_item3 = value
		item3_name_label.text = value.name
		item3_texture_rect.texture = value.texture
		item3_cost_label.text = str(value.cost_price)
		if value.cost_price == -10:
			item3_not_in_inventory_panel.visible = true
			item3_cost_label.text = ""
		else:
			item3_not_in_inventory_panel.visible = false

var _item4: Item:
	get:
		return _item4
	set(value):
		_item4 = value
		item4_name_label.text = value.name
		item4_texture_rect.texture = value.texture
		item4_cost_label.text = str(value.cost_price)
		if value.cost_price == -10:
			item4_not_in_inventory_panel.visible = true
			item4_cost_label.text = ""
		else:
			item4_not_in_inventory_panel.visible = false

var _item5: Item:
	get:
		return _item5
	set(value):
		_item5 = value
		item5_name_label.text = value.name
		item5_texture_rect.texture = value.texture
		item5_cost_label.text = str(value.cost_price)
		if value.cost_price == -10:
			item5_not_in_inventory_panel.visible = true
			item5_cost_label.text = ""
		else:
			item5_not_in_inventory_panel.visible = false

var _item6: Item:
	get:
		return _item6
	set(value):
		_item6 = value
		item6_name_label.text = value.name
		item6_texture_rect.texture = value.texture
		item6_cost_label.text = str(value.cost_price)
		if value.cost_price == -10:
			item6_not_in_inventory_panel.visible = true
			item6_cost_label.text = ""
		else:
			item6_not_in_inventory_panel.visible = false

var _item7: Item:
	get:
		return _item7
	set(value):
		_item7 = value
		item7_name_label.text = value.name
		item7_texture_rect.texture = value.texture
		item7_cost_label.text = str(value.cost_price)
		if value.cost_price == -10:
			item7_not_in_inventory_panel.visible = true
			item7_cost_label.text = ""
		else:
			item7_not_in_inventory_panel.visible = false

var _result_item: Item:
	get:
		return _result_item
	set(value):
		_result_item = value
		result_item_name_label.text = value.name
		result_item_texture_rect.texture = value.texture
		print("setting texture to ", value.texture)
		result_item_cost_label.text = str(value.cost_price)


func _ready() -> void:
	# Reset all default item displays
	item1_name_label.text = ""
	item1_texture_rect.texture = null
	item1_cost_label.text = ""

	item2_name_label.text = ""
	item2_texture_rect.texture = null
	item2_cost_label.text = ""

	item3_name_label.text = ""
	item3_texture_rect.texture = null
	item3_cost_label.text = ""

	item4_name_label.text = ""
	item4_texture_rect.texture = null
	item4_cost_label.text = ""

	item5_name_label.text = ""
	item5_texture_rect.texture = null
	item5_cost_label.text = ""

	item6_name_label.text = ""
	item6_texture_rect.texture = null
	item6_cost_label.text = ""

	item7_name_label.text = ""
	item7_texture_rect.texture = null
	item7_cost_label.text = ""

	result_item_name_label.text = ""
	result_item_texture_rect.texture = null
	result_item_cost_label.text = ""


## [code]result_item[/code]: Item to be crafted
## [codeblock]
##
## Usage
## if (result.get("success")):
##     var crafting_menu_row_instance: CraftingMenuRow = result.get("row")
##     rows_container.add_child(crafting_menu_row_instance)
## else:
##     pass
##[/codeblock]
static func create(recipe: Array[Item], result_item: Item) -> Dictionary:
	print("row factory called")

	# Prevents creating empty rows for items that can't be crafted
	if recipe.is_empty():
		return { "success": false, "row": null }

	var row: CraftingMenuRow = crafting_menu_row_packed_scene.instantiate() as CraftingMenuRow

	# Ensures row control nodes are fully initialized before setting items (Nill error)
	row.call_deferred("_set_items", recipe, result_item)

	return { "success": true, "row": row }


func _set_items(recipe: Array[Item], result_item: Item) -> void:
	print("size is", recipe.size())
	if recipe.size() >= 1:
		_item7 = recipe[0]
	if recipe.size() >= 2:
		_item6 = recipe[1]
	if recipe.size() >= 3:
		_item5 = recipe[2]
	if recipe.size() >= 4:
		_item4 = recipe[3]
	if recipe.size() >= 5:
		_item3 = recipe[4]
	if recipe.size() >= 6:
		_item2 = recipe[5]
	if recipe.size() >= 7:
		_item1 = recipe[6]

	set_up_result_item_button(recipe, result_item)

	_result_item = result_item


## Sets result item cost as a sum of all items
## If an item's cost is -10 (i.g. not in inventory), disables the result item button
func set_up_result_item_button(recipe: Array[Item], result_item: Item) -> void:
	var sum = 0

	for item in recipe:
		if item.cost_price == -10:
			result_item_button.disabled = true
			break
		sum = sum + item.cost_price

	result_item.cost_price = sum
