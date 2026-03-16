class_name ChangePlayerNameUseCase
extends RefCounted

func execute(player_name: String) -> void:
	print("[DEV][A] Changing player name...")

	StateManager.get_player_state().set_player_name(player_name)
