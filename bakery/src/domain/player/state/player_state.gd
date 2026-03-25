class_name PlayerState
extends RefCounted

var _player_name: String
var _player_location: EnumHolder.Location
var _player_balance: int


func _init() -> void:
	_player_name = ""

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
