class_name SellerBase extends CharacterBody2D

@export var ID : int

var shop_items: Array[String]

signal shop_items_updated()

@onready var tradeable_component = $TradeableComponent


func set_shop_items(item_list : Array[String]) -> void:
	if item_list != null:
		shop_items = item_list
		emit_signal("shop_items_updated")


func get_shop_items() -> Array[String]:
	return shop_items


func _ready():
	global_ref_register.register_seller(ID, self)
	
	shop_items.clear()
	shop_items.append((path_holder.CHERRY_CAKE_SCENE + ", 13"))
	shop_items.append((path_holder.BAGEL_SCENE + ", 13"))
	shop_items.append((path_holder.DONUT_SCENE + ", 13"))
	shop_items.append((path_holder.CHERRY_SCENE + ", 13"))
	shop_items.append((path_holder.MILK_SCENE + ", 13"))
	shop_items.append((path_holder.BREAD_SCENE + ", 13"))
	shop_items.append((path_holder.BREAD_SCENE + ", 13"))
	shop_items.append((path_holder.BREAD_SCENE + ", 13"))
	tradeable_component.initialize_seller_gui()
