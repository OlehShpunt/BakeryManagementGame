class_name TeleportPlayerUseCase
extends RefCounted

func execute(destination: EnumHolder.Location) -> void:
	EventBus.load_location.emit(destination)
