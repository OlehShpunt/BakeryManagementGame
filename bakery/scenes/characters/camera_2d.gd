extends Camera2D

func _enter_tree():
	print(">>>>>> func called")
	match get_tree().current_scene.name:
		"Street":
			zoom = Vector2(4.5, 4.5)
		_:
			zoom = Vector2(6, 6)

## Smooth camera transition
func set_camera_zoom(target_zoom: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "zoom", target_zoom, 1.0)  # 1 second transition
