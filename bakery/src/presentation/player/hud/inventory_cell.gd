class_name InventoryCell extends Panel

@onready var texture = $CenterContainer/TextureRect
@onready var flour = preload("res://scenes/food/ingredients/flour.tscn")
var inventory_resource = preload("res://resources/gui/inventory_resource.tres")
var mouse_is_hovering = false
var moved_item
var id : int
var is_occupied = true

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if inventory_resource.get_item(id):
		texture.set_texture(item_form_converter.string_to_texture(inventory_resource.get_item(id)))

func empty_cell():
	texture.set_texture(null)

func _on_cell_mouse_entered() -> void:
	mouse_is_hovering = true

func _on_cell_mouse_exited() -> void:
	mouse_is_hovering = false

##TO DO: need to add a item holding manager, which will store the item that's being moved.
##TO DO: copy some code from here to InventoryCell (can't use inheritance, no components => no composition)

func _input(event: InputEvent) -> void:
	# PICK ITEM
	# When hover over cell and left click, you pick the item and move it.
	if event.is_action_pressed("left_click") and mouse_is_hovering and texture.get_texture() != null:
		#DEPRECATED var item_scene = converter.string_to_scene(inventory_resource.items[id])
		## !!! NEED TO ADD SECOND ARGUMENT TO get_packed_scene(str, here) TO BE ABLE TO CARRY StUFF OTHER THAN INGREDIENTS (DeFAUlt)
		var item_scene = scene_manager.get_packed_scene(inventory_resource.get_item(id))
		inventory_resource.remove_item(id)
		add_child(item_scene.instantiate())
		empty_cell() # remove the texture from this cell
		# Access the last child - the flour. When _ true, the global pos is same as mouse's gl pos
		get_child(-1).is_being_moved_by_mouse = true

# Like player() method in Player class (use has_method() to check whether it can store items)
func inventory_cell():
	pass

# DEBUG
func _on_timer_timeout() -> void:
	#empty_cell()
	pass
