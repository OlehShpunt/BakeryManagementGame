class_name SellerUiItemRowHBoxContainer
extends HBoxContainer

func assign_item(item: Item) -> void:
	$ItemTextureRect.texture = item.texture
	$ItemNameLabel.text = item.name
	$ItemPriceLabel.text = "$" + str(item.sale_price)
