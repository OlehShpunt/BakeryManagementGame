class_name CellBase 
extends Control


@onready var texture_rect : TextureRect = $Panel/CenterContainer/TextureRect
@onready var active_state_frame : Panel = $ActiveStateFrame
@onready var cell_area = $Panel/InventoryCellAreaUi


var cell_id = -1
var current_item_scene_path = path_holder.EMPTY
var is_mouse_hovering = false


## Specify in child class
var cell_data


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	cell_data = get_cell_data()
	
	# Debug
	$Label.text = str(cell_id)
	
	# Fill the inventory gui if there is anything in the local_player_data inventory
	on_inventory_contents_changed(cell_id)
	self.update_image()
	
	# Make active or unactive
	on_current_active_cell_changed(cell_data.current_active_cell)
	
	cell_area.mouse_entered.connect(on_mouse_entered)
	cell_area.mouse_exited.connect(on_mouse_exited)
	
	cell_data.inventory_contents_changed.connect(on_inventory_contents_changed)
	cell_data.current_active_cell_changed.connect(on_current_active_cell_changed)




var debug = 0


func _process(delta: float) -> void:
	debug += 1
	
	if debug == 500:
		print(cell_id, " is monitorable: ", cell_area.monitorable)
		print(cell_id, " is monitoring: ", cell_area.monitoring)


## Whenever the inventory contents in local_player_data change, this function 
## updates the current_item_scene_path variable and updates the cell image
func on_inventory_contents_changed(changed_cell_id):
	if changed_cell_id == cell_id:
		current_item_scene_path = cell_data.get_inventory_item(cell_id)
		update_image()


## Whenever the current_active_cell changes in local_player_data, this function
## activates/disactivates the current cell
func on_current_active_cell_changed(current_active_cell):
	if current_active_cell == cell_id:
		self.make_active()
	else:
		self.make_unactive()


## Updates the cell texture image
func update_image():
	var image_path = item_form_converter.get_image_path_from_scene(current_item_scene_path)
	var texture = item_form_converter.get_texture_from_image_path(image_path)
	
	texture_rect.set_texture(texture)


## Shows the active frame around the cell
func make_active():
	if active_state_frame:
		active_state_frame.show()
		print("ACTIVATED")
	else:
		push_warning("active_state_frame is null")


## Hides the active frame around the cell
func make_unactive():
	if active_state_frame:
		active_state_frame.hide()
		print("DISACTIVATED")
	else:
		push_warning("active_state_frame is null")


func _input(event):
	if event.is_action_pressed("left_click"):
		on_mouse_click()


func on_mouse_click():
	if is_mouse_hovering:
		
		# Deactivate (this sell has nothing it)
		# If this cell is already active - deactivate it and set the current active to none, i.g. -1
		if cell_data.get_current_active_cell() == cell_id:
			cell_data.set_current_active_cell(-1)
		#Activate (this sell has something)
		else:
			
			# Do not activate the cell if there's nothing in the cell
			if not current_item_scene_path == path_holder.EMPTY:
				# This sets an id of this cell as the active id
				# local_player_data then emits the signal which makes this cell
				# become active (if the current_active_cell == self.cell_id)
				cell_data.set_current_active_cell(self.cell_id)


func on_mouse_entered():
	print("MOUSE ENTERED")
	is_mouse_hovering = true


func on_mouse_exited():
	print("MOUSE EXITED")
	is_mouse_hovering = false


func set_cell_data(data_source) -> void:
	cell_data = data_source


func get_cell_data():
	push_error("Implement this function in the child")
