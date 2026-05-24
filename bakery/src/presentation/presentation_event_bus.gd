extends Node

### Seller Signals
@warning_ignore("unused_signal")
signal show_seller_ui(seller_id: int)
@warning_ignore("unused_signal")
signal hide_seller_ui()

### Player Signals
@warning_ignore("unused_signal")
signal disable_player_movement()
@warning_ignore("unused_signal")
signal enable_player_movement()
@warning_ignore("unused_signal")
signal player_entered_cooking_area()
@warning_ignore("unused_signal")
signal player_left_cooking_area()

## Global Signals
@warning_ignore("unused_signal")
signal deselect_all_cells()
