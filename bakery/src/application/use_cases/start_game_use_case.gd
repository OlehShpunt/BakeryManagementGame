class_name StartGameUseCase
extends RefCounted

var load_street_location_use_case: LoadStreetLocationUseCase
var spawn_player_use_case: SpawnPlayerUseCase


func _init() -> void:
	load_street_location_use_case = LoadStreetLocationUseCase.new()
	spawn_player_use_case = SpawnPlayerUseCase.new()


func execute():
	load_street_location_use_case.execute()
	spawn_player_use_case.execute.call_deferred(Vector2(20, 20))
	#spawn_player_use_case.execute(Vector2(20, 20))
	EventBus.start_game.emit()

	print("[DEV][A] Starting the game...")
