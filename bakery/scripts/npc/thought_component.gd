extends Node2D

@onready var grid = $PanelContainer/GridContainer

## Displays the items as images
## TODO for strings as well to make possible to add text, not just images

func display(items: Array):
	# Remove all current children
	for existing_item in grid.get_children():
		existing_item.queue_free()
	
	if not items.is_empty():
		for item_path in items:
			var sprite: Sprite2D = load(item_path).instantiate()
			var texture = sprite.texture
			if texture == null:
				print("!! Could not load texture:", item_path)
				continue

			# Create a TextureRect (Control node that can display a texture)
			var image_rect: TextureRect = TextureRect.new()
			image_rect.texture = texture
			image_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
			image_rect.position = Vector2(-8, -8)
			#image_rect.expand = true
			image_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

			# Wrap in a Panel for background/border if needed
			var panel := Panel.new()
			
			panel.add_child(image_rect)

			grid.add_child(panel)
