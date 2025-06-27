extends Camera2D

func _enter_tree():
	match get_tree().current_scene.name:
		"Street":
			limit_left = 0
			limit_top = 0
			limit_right = 1920
			limit_bottom = 1665
			zoom = Vector2(3.85, 3.85)
		_:
			limit_left = -1000
			limit_top = -1000
			limit_right = 1000
			limit_bottom = 1000
			zoom = Vector2(6, 6)

## Smooth camera transition
func set_camera_zoom(target_zoom: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "zoom", target_zoom, 1.0)  # 1 second transition
