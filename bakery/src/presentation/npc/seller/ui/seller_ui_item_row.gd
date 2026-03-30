class_name SellerUiItemRowHBoxContainer
extends HBoxContainer

var _id: int
var seller_ui_item_row_state: SellerUiItemRowState

var id: int:
	set(value):
		_id = value
	get():
		return _id


func assign_item(item: Item) -> void:
	$ItemTextureRect.texture = item.texture
	$ItemNameLabel.text = item.name
	$ItemPriceLabel.text = "$" + str(item.sale_price)
