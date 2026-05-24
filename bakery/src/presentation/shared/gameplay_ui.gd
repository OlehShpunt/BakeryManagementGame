extends Control

@onready var crafting_menu: CraftingMenu = $CanvasLayer/CraftingMenu
@onready var seller_ui = $CanvasLayer/SellerUi


func _ready() -> void:
	crafting_menu.close_crafting_menu_button_pressed.connect(_on_close_crafting_menu_pressed)


func _on_open_crafting_menu_pressed() -> void:
	crafting_menu.show()
	seller_ui.hide()


func _on_close_crafting_menu_pressed() -> void:
	crafting_menu.hide()
