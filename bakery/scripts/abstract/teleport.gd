class_name Teleport  ## Requires CollisionShape2D
extends Area2D  

# The scene where this Teleport is located (teleport's scene location)
@onready var teleports_scene_location = self.get_owner() 
@export_enum("street", "bakery_1", "shop_1") var teleport_to : String

func _ready() -> void:
	#connect("body_entered", _on_body_entered)
	pass

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if (body.has_method("player")):
		#print(destination.get_path())
		#get_tree().change_scene_to_packed(destination) - already in transition scene
		scene_manager.transition_scene(get_owner(), self, body)
		print("DEBUG: changing scene because " + body.name.substr(0, 6) + " entered the teleport area")
		
