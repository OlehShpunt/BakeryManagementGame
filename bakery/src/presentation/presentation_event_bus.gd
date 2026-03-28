extends Node

### Seller Signals
@warning_ignore("unused_signal")
signal show_seller_ui(seller_id: int)
@warning_ignore("unused_signal")
signal hide_seller_ui()

## Player Signals
@warning_ignore("unused_signal")
signal disable_player_movement()
signal enable_player_movement()
