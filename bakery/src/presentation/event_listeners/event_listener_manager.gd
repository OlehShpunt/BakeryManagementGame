extends Node

var location_event_listener: LocationEventListener
var player_event_listener: PlayerEventListener


func _init() -> void:
	location_event_listener = LocationEventListener.new()
	add_child(location_event_listener)

	player_event_listener = PlayerEventListener.new()
	add_child(player_event_listener)
