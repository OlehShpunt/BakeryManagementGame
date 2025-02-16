class_name StorageCell extends Panel

@onready var texture = $CenterContainer/TextureRect
@onready var flour = preload("res://scenes/food/ingredients/flour.tscn")
@onready var converter = preload("res://resources/gui/item_form_converter.tres")
var resource = preload("res://resources/objects/storage1_resource.tres")
var mouse_is_hovering = false
var moved_item
@export var id : int
var is_occupied = true

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	print(resource.resource_name)
	print("THE item: id=", id, "; ", resource.get_item(id))
	if resource.get_item(id):
		texture.set_texture(converter.string_to_texture(resource.get_item(id)))

func empty_cell():
	texture.set_texture(null)

func _on_cell_mouse_entered() -> void:
	mouse_is_hovering = true

func _on_cell_mouse_exited() -> void:
	mouse_is_hovering = false

##TO DO: need to add an item holding manager, which will store the item that's being moved.
##TO DO: copy some code from here to InventoryCell (can't use inheritance, no components => no composition)

func _input(event: InputEvent) -> void:
	# When hover over cell and left click, you pick the item and move it.
	if event.is_action_pressed("left_click") and mouse_is_hovering and texture.get_texture() != null:
		#var item_scene = converter.string_to_scene(storage1_resource.items[id])
		var item_scene = scene_manager.get_packed_scene(resource.get_item(id))
		resource.remove_item(id)
		add_child(item_scene.instantiate())
		empty_cell() # remove the texture from this cell
		# Access the last child - the flour. When _ true, the global pos is same as mouse's gl pos
		get_child(-1).is_being_moved_by_mouse = true

# Like player() method in Player class (use has_method() to check whether it can store items)
func storage_cell():
	pass

# DEBUG
func _on_timer_timeout() -> void:
	#empty_cell()
	pass
