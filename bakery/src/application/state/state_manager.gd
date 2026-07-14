extends Node

var _player_state: PlayerState
var _seller_states: Dictionary[int, SellerState]
var _global_state: GlobalState
var _ws_client: WebSocketClient
var _multiplayer_player_states: Dictionary[String, MultiplayerPlayerState]


func _init() -> void:
	_global_state = GlobalState.new()
	_player_state = PlayerState.new()

	_ws_client = WebSocketClient.new()
	add_child(_ws_client)
	_ws_client.player_joined_lobby.connect(_on_player_joined_lobby)

	print("[DEV][A] State manager initialized")


func _on_player_joined_lobby(id: String, name: String) -> void:
	if (id == null or name == null):
		return

	var state := MultiplayerPlayerState.new(id, name)

	_multiplayer_player_states.set(id, state)

	# Create new multiplayer player in presentation layer
	MultiplayerPlayerDisplay.register_player(state)


func get_global_state() -> GlobalState:
	return _global_state


func get_player_state() -> PlayerState:
	return _player_state


## Registers a new state and returns it.
## If already registered, returns the registered state.
func register_seller_state(seller_id: int) -> SellerState:
	return _seller_states.get_or_add(seller_id, SellerState.new(seller_id))


func get_seller_state(seller_id: int) -> SellerState:
	if (seller_id == null or !_seller_states.has(seller_id)):
		return null
	return _seller_states.get(seller_id)
