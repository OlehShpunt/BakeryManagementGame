class_name Seller
extends CharacterBody2D

@export var id: int
var _seller_state: SellerState
@onready var sprite: Sprite2D = $SellerSprite2D


func _ready() -> void:
	_seller_state = StateManager.register_seller_state(id)
	sprite.material.set("shader_param/outline_enabled", false)
	$TextureButton.mouse_default_cursor_shape = 0


func _on_texture_button_pressed() -> void:
	var player := StateManager.get_player_state().player_ref

	if (!$Area2D.overlaps_body(player)):
		print("doesn't overlap - not showing the menu")
		return

	PresentationEventBus.show_seller_ui.emit(id)


func _on_area_2d_body_entered(body: Player) -> void:
	sprite.material.set("shader_param/outline_enabled", true)
	$TextureButton.mouse_default_cursor_shape = 2


func _on_area_2d_body_exited(body: Player) -> void:
	sprite.material.set("shader_param/outline_enabled", false)
	$TextureButton.mouse_default_cursor_shape = 0
