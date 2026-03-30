class_name SellerUiItemRowHBoxContainer
extends HBoxContainer

@onready var action_button: Button = $Button

var _id: int
var _seller_ui_item_row_state: SellerUiItemRowState

var id: int:
	set(value):
		_id = value
	get():
		return _id

var seller_ui_item_row_state: SellerUiItemRowState:
	get():
		return _seller_ui_item_row_state
	set(state):
		_seller_ui_item_row_state = state


func _ready() -> void:
	if (seller_ui_item_row_state.is_sold):
		action_button.text = "Sold"
	else:
		action_button.text = "Buy"

	action_button.disabled = seller_ui_item_row_state.is_sold

	seller_ui_item_row_state.is_sold_updated.connect(_on_is_sold_updated)


func assign_item(item: Item) -> void:
	$ItemTextureRect.texture = item.texture
	$ItemNameLabel.text = item.name
	$ItemPriceLabel.text = "$" + str(item.sale_price)


func _on_button_pressed() -> void:
	var cell_id := StateManager.get_player_state().get_first_empty_cell_state_id()

	# Is inventory full?
	if (cell_id == -1):
		return

	var balance := StateManager.get_player_state().balance
	var item := seller_ui_item_row_state.item

	# Does the player have enough money?
	if (balance < item.sale_price):
		return
	StateManager.get_player_state().subtract_balance_amount(item.sale_price)

	# NOTE: Item sale_price is passed as cost_price
	var item_copy: Item = Item.new(item.item_code, item.sale_price)
	StateManager.get_player_state().set_inventory_item(cell_id, item_copy)
	seller_ui_item_row_state.is_sold = true


func _on_is_sold_updated(is_sold: bool) -> void:
	action_button.disabled = is_sold
