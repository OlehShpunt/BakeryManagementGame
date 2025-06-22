class_name SellerGUIItemData extends HBoxContainer


var ID = -1


#@onready var seller_gui_node : SellerGUI = get_parent()
@onready var texture_rect : TextureRect = $TextureRect
@onready var purchase_button : Button = $PurchaseButton
@onready var label : Label = $Label

var inventory_resource : InventoryResource = preload("res://resources/gui/inventory_resource.tres")
#var item : String
var item_scene_path : String = path_holder.EMPTY


var price : int
var price_difference: int
var sold_out = false
var current_color = COLOR_REG_0_BLACK


const COLOR_PLS_2_PURPLE = Color(100, 0, 120)
const COLOR_PLS_1_RED =    Color(200, 0, 0)
const COLOR_REG_0_BLACK =  Color(0, 0, 0)
const COLOR_MIN_1_GREEN =  Color(0, 210, 0)
const COLOR_MIN_2_GOLD =   Color(255, 185, 1)


func _ready() -> void:
	if item_scene_path != path_holder.EMPTY:
		
		# Resolving price
		# I.g. the "-1" "0" "+1" ...
		price_difference = price
		price = Finance.resolve_price(item_scene_path) + price_difference
		
		# Setting color depending on the price_difference
		match price_difference:
			2:
				current_color = COLOR_PLS_2_PURPLE
			1:
				current_color = COLOR_PLS_1_RED
			0:
				current_color = COLOR_REG_0_BLACK
			-1:
				current_color = COLOR_MIN_1_GREEN
			-2:
				current_color = COLOR_MIN_2_GOLD
			_:
				current_color = Color(255, 255, 255)
		
		purchase_button.add_theme_color_override("font_color", current_color)
		
		# Setting item price in gui
		purchase_button.text = str(price) + "$"
		
		# Setting item name in gui
		label.text = load(item_scene_path).instantiate().get_item_string().capitalize()
		
		# Is sold out?
		if sold_out:
			item_sold_out()
	else: 
		push_error("value of item is not specified")
	
	texture_rect.texture = item_form_converter.get_texture_from_scene_path(item_scene_path)

# Adds the item to the first available player's inventory cell
func _on_button_pressed() -> void:
	
	if local_player_data.balance < self.price:
		return
	
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
				
				# Finance logic
				local_player_data.balance = local_player_data.balance - self.price
				
				break
	
	# If no space in player's inventory
	if !item_added:
		print("{SELLER_GUI_ITEM_DATA} Could not add item - player's inventory is full")


func item_sold_out():
	sold_out = true
	label.set("theme_override_colors/font_color", Color.DIM_GRAY)
	purchase_button.disabled = true


func _on_tree_exiting() -> void:
	if sold_out:
		print("+++ this one with ID ", ID, "is sold out, so saving it")
		# Getting seller_gui.tradeable_component.seller
		var seller_id: int = get_seller_gui().get_tradeable_component().get_parent().ID
		var new_data = item_scene_path + ", " + str(price) + ", " + str(sold_out)
		print("+++ new data is ", new_data)
		client_ui_data.set_seller_shop_item(seller_id, self.ID, new_data)


func get_seller_gui():
	return get_parent().get_parent().get_parent().get_parent()


#func get_item():
	#texture_rect.get_texture()

#func set_item_texture(item_name : String) -> void:
	#texture_rect.set_texture(item_form_converter.string_to_texture(item_name))

#func set_label_text(item_name : String) -> void:
	#texture_rect.set_texture(item_form_converter.string_to_texture(item_name))

#func set_item_price(item_price : int) -> void:
	#purchase_button.text = str(item_price) + "$"
