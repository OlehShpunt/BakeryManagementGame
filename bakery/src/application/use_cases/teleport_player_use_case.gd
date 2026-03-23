class_name TeleportPlayerUseCase
extends RefCounted

func execute(destination: EnumHolder.Location):
	EventBus.load_location.emit(destination)
