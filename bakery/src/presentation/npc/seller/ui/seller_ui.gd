extends Control

var seller_ui_item_row_scene = preload(("res://src/presentation/npc/seller/ui/seller_ui_item_row.tscn"))
@onready var item_list_container: VBoxContainer = $Panel/ScrollContainer/ItemVBoxContainer


func _init() -> void:
	PresentationEventBus.show_seller_ui.connect(_on_show_seller_ui)
	PresentationEventBus.hide_seller_ui.connect(_on_hide_seller_ui)


## Renders seller UI depending on seller_id
func _on_show_seller_ui(seller_id: int):
	var seller_state := StateManager.get_seller_state(seller_id)

	var items: Array[Item]

	if (seller_state == null or seller_state.seller_item_list == null):
		items = []
	else:
		items = seller_state.seller_item_list.get_array()

	for item in items:
		_render_item(item)

	self.show()


# TODO: Optimize by caching
func _on_hide_seller_ui():
	var children := item_list_container.get_children()
	for child in children:
		child.queue_free()
		item_list_container.remove_child(child)
	self.hide()


func _render_item(item: Item):
	var item_row: SellerUiItemRowHBoxContainer = seller_ui_item_row_scene.instantiate()
	item_row.assign_item(item)
	item_list_container.add_child(item_row)


func _on_button_pressed() -> void:
	PresentationEventBus.hide_seller_ui.emit()
