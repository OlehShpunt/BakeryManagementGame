class_name StartGameUseCase
extends RefCounted

var load_location_use_case: LoadLocationUseCase


func _init() -> void:
	load_location_use_case = LoadLocationUseCase.new()


func execute() -> void:
	load_location_use_case.execute(EnumHolder.Location.Street)
	EventBus.start_game.emit()

	print("[DEV][A] Starting the game...")
