class_name LoadLocationUseCase
extends RefCounted

func execute(location: EnumHolder.Location) -> void:
	print("[DEV][A] Loading street location...")

	EventBus.load_location.emit(location)
