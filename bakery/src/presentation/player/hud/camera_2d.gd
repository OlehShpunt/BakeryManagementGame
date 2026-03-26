extends Camera2D

func _init() -> void:
	var _err: int = DomainEventBus.player_location_updated.connect(_on_player_location_updated)


func _on_player_location_updated() -> void:
	match StateManager.get_player_state().get_player_location():
		EnumHolder.Location.Street:
			limit_left = 0
			limit_top = 0
			limit_right = 1920
			limit_bottom = 1665
			zoom = Vector2(3.85, 3.85)
			#set_camera_zoom(Vector2(3.85, 3.85))
		_:
			limit_left = -2000
			limit_top = -2000
			limit_right = 2000
			limit_bottom = 2000
			zoom = Vector2(4.5, 4.5)
			#set_camera_zoom(Vector2(4.5, 4.5))


## Smooth camera transition
func set_camera_zoom(target_zoom: Vector2) -> void:
	var tween: Tween = create_tween()
	var _property_tweener: PropertyTweener = tween.tween_property(self, "zoom", target_zoom, 1.0) # 1 second transition
