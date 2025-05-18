class_name SellerGUIItemData extends HBoxContainer

#@onready var seller_gui_node : SellerGUI = get_parent()
@onready var texture_rect : TextureRect = $TextureRect
@onready var purchase_button : Button = $Button
@onready var label : Label = $Label
var inventory_resource : InventoryResource = preload("res://resources/gui/inventory_resource.tres")
#var item : String
var price : int
var sold_out = false
## TODO: Will be changed by item distribution algorithms 
## when generating the seller's item list
#moved to ready
#var item_packed_scene : PackedScene
var item_scene_path : String = path_holder.EMPTY

func _ready() -> void:
	if item_scene_path != path_holder.EMPTY:
		
		# Setting item price in gui
		purchase_button.text = str(price) + "$"
		
		# Setting item name in gui
		#var item_packed_scene = load(item_scene_path)
		#push_warning("----->>>>", item_scene_path)
		label.text = load(item_scene_path).instantiate().get_item_string().capitalize()
	
	else: 
		push_error("value of item is not specified")
	
	texture_rect.texture = item_form_converter.get_texture_from_scene_path(item_scene_path)

# Adds the item to the first available player's inventory cell
func _on_button_pressed() -> void:
	print("{SELLER_GUI_ITEM_DATA} Button pressed!")
	
	var item_added = false
	
	for i in range(local_player_data.inventory_size):
		
		# Control variable
		if !item_added:
			
			# Prevent adding to cell if it's already taken by other item
			if local_player_data.get_inventory_item(i) == path_holder.EMPTY:
				
				print("{SELLER_GUI_ITEM_DATA} Adding bought item to cell ", i)
				local_player_data.set_inventory_item(i, item_scene_path)
				# Reset current selected cell to prevent unexpected behavior (e.g. when an item is bought from seller, and placed into the cell that is already active, the current item would need to be updated in client_ui_data. For making it less complex, the selected cell is simply deselected when a new item is set)
				client_ui_data.set_current_active_cell_id(-1, -1, path_holder.EMPTY)
				
				item_added = true
				
				# Disable this whole gui
				item_sold_out()
				
				## TO-DO: MINUS MONEY FROM PLAYER RIGHT HERE
				
				break
	
	# If no space in player's inventory
	if !item_added:
		print("{SELLER_GUI_ITEM_DATA} Could not add item - player's inventory is full")

func item_sold_out():
	sold_out = true
	label.set("theme_override_colors/font_color", Color.DIM_GRAY)
	purchase_button.disabled = true


#func get_item():
	#texture_rect.get_texture()

#func set_item_texture(item_name : String) -> void:
	#texture_rect.set_texture(item_form_converter.string_to_texture(item_name))

#func set_label_text(item_name : String) -> void:
	#texture_rect.set_texture(item_form_converter.string_to_texture(item_name))

#func set_item_price(item_price : int) -> void:
	#purchase_button.text = str(item_price) + "$"
