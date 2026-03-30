extends Control

var seller_ui_item_row_scene = preload(("res://src/presentation/npc/seller/ui/seller_ui_item_row.tscn"))
@onready var item_list_container: VBoxContainer = $Panel/ScrollContainer/ItemVBoxContainer


func _init() -> void:
	PresentationEventBus.show_seller_ui.connect(_on_show_seller_ui)
	PresentationEventBus.hide_seller_ui.connect(_on_hide_seller_ui)


## Renders seller UI depending on seller_id
func _on_show_seller_ui(seller_id: int):
	PresentationEventBus.disable_player_movement.emit()

	var seller_state := StateManager.get_seller_state(seller_id)

	var rows: Dictionary[int, SellerUiItemRowState]

	if (seller_state == null or seller_state.seller_item_list == null):
		rows = { }
	else:
		rows = seller_state.seller_item_list

	for row_id in rows:
		_render_row(rows.get(row_id))

	self.show()


# TODO: Optimize by caching
func _on_hide_seller_ui():
	PresentationEventBus.enable_player_movement.emit()

	var children := item_list_container.get_children()
	for child in children:
		child.queue_free()
		item_list_container.remove_child(child)
	self.hide()


func _render_row(row_state: SellerUiItemRowState):
	var item_row: SellerUiItemRowHBoxContainer = seller_ui_item_row_scene.instantiate()
	item_row.seller_ui_item_row_state = row_state
	item_row.id = row_state.row_id
	item_row.assign_item(row_state.item)
	#seller_state.register_item_row()
	item_list_container.add_child(item_row)


func _on_button_pressed() -> void:
	PresentationEventBus.hide_seller_ui.emit()
