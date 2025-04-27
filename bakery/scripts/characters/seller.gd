class_name SellerBase extends CharacterBody2D


var shop_items: Array[String]
@onready var tradeable_component = $TradeableComponent


func _ready():
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
