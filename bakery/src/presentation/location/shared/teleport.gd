class_name Teleport  ## Requires CollisionShape2D
extends Area2D  


@export var id : int = -1


# The scene where this Teleport is located (teleport's scene location)
@onready var teleports_scene_location = self.get_owner() 
@export_enum(path_holder.STREET_PATH, path_holder.BAKERY_1_PATH, path_holder.MINI_MARKET_PATH, path_holder.WHOLESALE_SHOP_PATH, path_holder.KIOSK_PATH, path_holder.SUPERMARKET_PATH) var teleport_to : String


func _ready() -> void:
	if id < 0:
		push_error("Teleport ID must be specified")
		return
	
	global_ref_register.register_teleport(self)


func _on_body_entered(body: Node2D) -> void:
	
	if (body.has_method("player")):
		if (body.is_multiplayer_authority()):
			request_teleport(teleport_to)


@rpc("any_peer", "call_local", "reliable")
func request_teleport(scene_path: String):
	print("teleport requested request_teleport() called")
	multiplayer_manager.rpc_id(1, "handle_teleport_request", scene_path)


func get_teleport_to_path():
	return teleport_to


func get_id():
	return id
