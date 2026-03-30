class_name PresentationUtils
extends RefCounted

static func items_array_to_dict(item_list: Item.ArrayOfItems, seller_id: int) -> Dictionary[int, SellerUiItemRowState]:
	var result: Dictionary[int, SellerUiItemRowState] = { }

	var items := item_list.get_array()

	for i in range(items.size()):
		var row_state := SellerUiItemRowState.new()

		row_state._row_id = i
		row_state._item = items[i]
		row_state._is_sold = false
		row_state._seller_id = seller_id

		result[i] = row_state

	return result
