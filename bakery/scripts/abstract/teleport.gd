class_name Teleport  ## Requires CollisionShape2D
extends Area2D  

# The scene where this Teleport is located (teleport's scene location)
@onready var teleports_scene_location = self.get_owner() 
@export_enum(path_holder.STREET_PATH, path_holder.BAKERY_1_PATH, path_holder.MINI_MARKET_PATH, path_holder.WHOLESALE_SHOP_PATH, path_holder.KIOSK_PATH, path_holder.SUPERMARKET_PATH) var teleport_to : String

func _ready() -> void:
	#connect("body_entered", _on_body_entered)
	pass

func _on_body_entered(body: Node2D) -> void:
	if (body.has_method("player")):
		print("body is player = true")
		if (body.is_multiplayer_authority()):
			print("body is multiplayer authority = true")
			request_teleport(teleport_to)
			#scene_manager.transition_scene(get_owner(), self, body)


@rpc("any_peer", "call_local", "reliable")
func request_teleport(scene_path: String):
	print("teleport requested request_teleport() called")
	#if multiplayer.get_unique_id() == 1:
		#return # server shouldn't request teleport
	multiplayer_manager.rpc_id(1, "handle_teleport_request", scene_path)
