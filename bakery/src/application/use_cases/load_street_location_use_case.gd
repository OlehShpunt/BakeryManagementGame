class_name LoadStreetLocationUseCase
extends RefCounted

func execute() -> void:
	print("[DEV][A] Loading street location...")

	EventBus.load_street_location.emit()
