class_name SellerGUIItemData extends HBoxContainer

#@onready var seller_gui_node : SellerGUI = get_parent()
@onready var texture_rect : TextureRect = $TextureRect
@onready var purchase_button : Button = $Button
@onready var label : Label = $Label
var inventory_resource : InventoryResource = preload("res://resources/gui/inventory_resource.tres")
var item : String
var price : int
var sold_out = false
## TODO: Will be changed by item distribution algorithms 
## when generating the seller's item list
#moved to ready
var item_packed_scene : PackedScene

func _ready() -> void:
	if (item):
		item_packed_scene = scene_manager.get_packed_scene(item, "ingredient")
		print(item_packed_scene.resource_name)
		purchase_button.text = str(price) + "$"
		label.text = item_packed_scene.instantiate().get_item_string().capitalize()
	else: 
		push_error("value of item is not specified")
	
	if item_packed_scene:
		texture_rect.texture = item_packed_scene.instantiate().get_texture()
	else:
		push_error("cannot display texture in SellerGUIItemData because item_packed_scene is null")

# Adds the item to the first available player's inventory cell
func _on_button_pressed() -> void:
	print("Button pressed!")
	var item_added = false
	for i in range(inventory_resource.items.size()):
		if !item_added:
			# Prevent adding to cell if it's already taken by other item
			if inventory_resource.items[i] == null or inventory_resource.items[i] == "":
				print("Adding ", item_packed_scene.resource_name, " to cell ", i)
				inventory_resource.add_item(i, item_packed_scene.resource_name)
				item_added = true
				# disable this whole gui
				item_sold_out()
				## TO-DO: MINUS MONEY FROM PLAYER RIGHT HERE
				break
	# If no space in player's inventory
	if !item_added:
		print("PLAYER'S INVENTORY IS FULL!!")

func item_sold_out():
	sold_out = true
	label.set("theme_override_colors/font_color", Color.DIM_GRAY)
	purchase_button.disabled = true


func get_item():
	texture_rect.get_texture()

func set_item_texture(item_name : String) -> void:
	texture_rect.set_texture(item_form_converter.string_to_texture(item_name))

func set_label_text(item_name : String) -> void:
	texture_rect.set_texture(item_form_converter.string_to_texture(item_name))

func set_item_price(item_price : int) -> void:
	purchase_button.text = str(item_price) + "$"
