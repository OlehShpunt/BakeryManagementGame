class_name SellerUiItemRowHBoxContainer
extends HBoxContainer

@onready var action_button: Button = $Button

var _id: int
var _seller_ui_item_row_state: SellerUiItemRowState
var sell_seller_item_to_player_use_case: SellSellerItemToPlayerUseCase = SellSellerItemToPlayerUseCase.new()

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
	var item_to_sell := seller_ui_item_row_state.item

	var success := sell_seller_item_to_player_use_case.execute(item_to_sell)
	
	if (success):
		seller_ui_item_row_state.is_sold = true


func _on_is_sold_updated(is_sold: bool) -> void:
	action_button.disabled = is_sold
