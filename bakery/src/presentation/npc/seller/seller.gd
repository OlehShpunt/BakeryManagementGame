class_name Seller
extends CharacterBody2D

@export var id: int
var _seller_state: SellerState


func _ready() -> void:
	_seller_state = StateManager.register_seller_state(id)
