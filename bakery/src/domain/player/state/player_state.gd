class_name PlayerState
extends RefCounted

var _player_name: String
var _player_location: EnumHolder.Location
var _player_balance: int
var _player_ref: Player
var _player_cell_state_ref_registry: Dictionary[int, CellState]

var player_ref: Player:
	set(player_ref):
		_player_ref = player_ref
	get():
		return _player_ref


func _init() -> void:
	_player_name = ""
	_player_balance = 50

	print("[DEV][D] PlayerState initialized")


func set_player_name(name: String) -> void:
	# TODO: Add player name validation using PlayerRules

	_player_name = name

	print("[DEV][D] Player name set to %s" % [_player_name])


func set_player_location(location: EnumHolder.Location) -> void:
	_player_location = location

	DomainEventBus.player_location_updated.emit()

	print("[DEV][D] Player Location set to %s" % [_player_location])


func get_player_name() -> String:
	print("[DEV][D] Returning Player Name %s" % [_player_name])
	return _player_name


func get_player_location() -> EnumHolder.Location:
	print("[DEV][D] Returning Player Location %s" % [_player_location])
	return _player_location


func register_cell_state(cell_id: int, cell_state: CellState) -> void:
	print("[DEBUG] registering cell state: ", cell_id, " --- value = ", cell_state)
	_player_cell_state_ref_registry.set(cell_id, cell_state)


func get_cell_state(cell_id: int) -> CellState:
	return _player_cell_state_ref_registry.get(cell_id)


func set_inventory_item(cell_id: int, item: Item) -> void:
	if (_player_cell_state_ref_registry.has(cell_id)):
		_player_cell_state_ref_registry[cell_id].item = item
	else:
		push_warning("Cell with id %s not found" % cell_id)


func get_inventory_item(cell_id: int) -> Item:
	var cell_state: CellState = _player_cell_state_ref_registry.get(cell_id)

	if (cell_state.item == null):
		return null

	return cell_state.item
