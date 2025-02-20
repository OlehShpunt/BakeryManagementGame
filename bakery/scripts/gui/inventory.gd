class_name Inventory extends GridContainer

@export var inventory_resource : InventoryResource

var number_of_cells : int
var cell : PackedScene = preload("res://scenes/gui/inventory_cell.tscn")
var inventory_open = false
# Inventory blocked when:
# 1) Player enters the InteractableZone of a Seller
var inventory_blocked = false

func _ready() -> void:
	self.number_of_cells = inventory_resource.num_of_cells
	
	if not inventory_open:
		self.hide()
	else:
		self.show()
	spawn_cells()

func _process(_delta: float) -> void:
	if inventory_blocked:
		self.hide()

func spawn_cells():
	for i in range(number_of_cells):
		self.add_child(cell.instantiate())
	# Setting id for each cell
	for i in range(number_of_cells):
		get_child(i).id = i

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		inventory_open = !inventory_open
		if inventory_open:
			self.show()
		else:
			self.hide()
