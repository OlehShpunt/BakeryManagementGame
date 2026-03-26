extends Area2D

@export var destination: EnumHolder.Location
var collision_shape: CollisionShape2D
var teleport_player_use_case: TeleportPlayerUseCase


func _ready() -> void:
	if (!$CollisionShape2D):
		free()

	collision_shape = $CollisionShape2D
	var _err: int = body_entered.connect(_on_body_entered)

	teleport_player_use_case = TeleportPlayerUseCase.new()


func _on_body_entered(_body: Player) -> void:
	teleport_player_use_case.execute(destination)
