## This class detects when entities enter the parent scene
## and teleport them to the entrance (desired start position).
## Requires CollisionShape2D (add right in parent scene)

extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	print("teleport to the starting location")
