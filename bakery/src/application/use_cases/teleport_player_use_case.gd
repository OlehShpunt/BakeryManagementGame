class_name TeleportPlayerUseCase
extends RefCounted

func execute(destination: EnumHolder.Location) -> void:
	EventBus.load_location.emit(destination)
	StateManager.get_player_state().set_player_location(destination)
	StateManager._ws_client.send_teleport_player(10, 10, destination) # x and y don't matter since the client will sends coordinate updates constantly
