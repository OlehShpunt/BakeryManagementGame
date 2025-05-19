class_name SellerBase extends CharacterBody2D

@export var ID : int

var shop_items: Array

signal shop_items_updated()

@onready var tradeable_component = $TradeableComponent


func set_shop_items(item_list : Array) -> void:
	if item_list != null:
		shop_items = item_list
		emit_signal("shop_items_updated")


## Reinitializes the seller's gui by adding new items based on self.shop_items
func on_shop_items_updated():
	tradeable_component.initialize_seller_gui()


func get_shop_items() -> Array:
	return shop_items


func _ready():
	global_ref_register.register_seller(ID, self)
	
	# Fill seller GUI with items specified in the global data holder client_ui_data
	shop_items.clear()
	if client_ui_data.get_seller_shop_items(str(ID)) is not int:
		#set_shop_items(client_ui_data.get_seller_shop_items(str(ID)))
		shop_items = client_ui_data.get_seller_shop_items(str(ID))
	tradeable_component.initialize_seller_gui()
	
	call_deferred("deffered_call_here")


func deffered_call_here():
	shop_items_updated.connect(on_shop_items_updated)
