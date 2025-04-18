class_name TradeableComponent extends Node2D

##TO-DO: Instead of exporting, should be accessed by the algorithm
@export var shop_items: Array[String]

@onready var dollar = $DollarSign
@onready var seller_gui = $DollarSign/SellerGUI
@onready var interactable_zone = $InteractableZone

var seller_gui_item_data : PackedScene = preload("res://scenes/gui/seller_gui_item_data.tscn")

var num_players_in_interactable_zone = 0
var mouse_is_hovering_dollar = false
# Basically the "shown" vars are not really needed in the if statements below (it's just for security).
# Those will be accessed by other scripts.
# IDK WHETHER I NEED THE if CHECKS using these 
# variables - MAYBE show() WON"T RAISE ERROR WHEN THE GUI IS ALREADY SHOWN - dunno :/
var dollar_shown = false # IGNORE AS A SEMANTIC IN IF STATEMENTS OF THIS SCRIPT
var seller_gui_shown = false # IGNORE AS A SEMANTIC IN IF STATEMENTS OF THIS SCRIPT

# !!! 
# THIS IS TEMP FUNCTIONALITY - PLAYER MUST BE ASSIGNED TEMPORARILY 
# DURING PURCHASE, BUT IT CAN BE DONE WHEN I WILL HAVE MULTIPLAYER IMPLEMENTED
var PLAYER : Player

func _ready() -> void:
	self.shop_items = get_parent().shop_items
	#print(shop_items)
	dollar.hide()
	seller_gui.hide()
	initialize_seller_gui() # Add items to gui

#Add specified items (specified by the shop_items export variable)
func initialize_seller_gui():
	# Each "item" is a string that holds coma-separated item data 
	# (its algorithm-generated name and price)
	for item in shop_items: 
		var shop_item : SellerGUIItemData = seller_gui_item_data.instantiate()
		##TO-DO: Set shop_item.item to the item name that I want to display - generated by the algorithm
		var i_data = item.split(",")
		# i_data: 0 = name, 1 = price
		# setting item name
		shop_item.item = i_data[0]
		# setting item price
		shop_item.price = i_data[1]
		##TO-DO: Set shop_item.price to the item price that I want to display - generated by the algorithm
		seller_gui.inside_container.add_child(shop_item)

# When player enters the tradeable zone, trade (dollar) is enabled
func _on_interactable_zone_body_entered(body: Node2D) -> void:
	if (body.has_method("player")):
		
		# !!! 
		# TEMPORARY - NEEDS REPLACEMENT AS SOON AS MULTIPLAYER IS IMPLEMENTED (see comments above)
		PLAYER = body
		
		# Block player's inventory to prevent him from accidentally moving their items while shopping (using seller_gui)
		body.block_inventory()
		
		num_players_in_interactable_zone += 1
		
		if (!dollar_shown): # Exception (lol what), there's where it's needed
			dollar_shown = true
			dollar.show()

# When all players exit the tradeable zone, trade (dollar) is disabled
func _on_interactable_zone_body_exited(body: Node2D) -> void:
	if (body.has_method("player")):
		
		# !!! 
		# TEMPORARY - NEEDS REPLACEMENT AS SOON AS MULTIPLAYER IS IMPLEMENTED (see comments above)
		PLAYER = null
		
		# Unblock player's inventory because it got blocked when he entered the interactable area
		body.unblock_inventory()
		
		num_players_in_interactable_zone -= 1
		if (dollar_shown and num_players_in_interactable_zone <= 0):
			dollar_shown = false
			dollar.hide()
			if (seller_gui_shown):
				seller_gui_shown = false
				seller_gui.hide()

# Allows opening the seller gui hovering over dollar
func _on_click_to_trade_mouse_entered() -> void:
	mouse_is_hovering_dollar = true
	#print("mouse entered dollar")

# Prevents the seller gui from opening when not hovering over dollar
func _on_click_to_trade_mouse_exited() -> void:
	mouse_is_hovering_dollar = false
	#print("mouse exited dollar")

# Open/Close seller GUI here
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and mouse_is_hovering_dollar:
		if not seller_gui_shown:
			seller_gui_shown = true
			seller_gui.show()
		else:
			# Prevent other players to close gui when another user is potentially using the gui
			# Otherwise, other could just spam close the 
			# seller GUI to prevent another player(s) from buyning items
			if (num_players_in_interactable_zone == 1):
				seller_gui_shown = false
				seller_gui.hide()
