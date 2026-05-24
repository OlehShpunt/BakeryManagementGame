class_name Bakery
extends Node2D

func _on_cooking_area_body_entered(body: Player) -> void:
	PresentationEventBus.player_entered_cooking_area.emit()


func _on_cooking_area_body_exited(body: Node2D) -> void:
	PresentationEventBus.player_left_cooking_area.emit()
