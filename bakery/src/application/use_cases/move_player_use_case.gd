class_name MovePlayerUseCase
extends RefCounted

func execute(x: float, y: float) -> void:
	StateManager._ws_client.send_move_player(x, y)
