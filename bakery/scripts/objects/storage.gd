class_name Storage extends GridContainer

var number_of_cells : int = 10
#storage cells
var cell : PackedScene = preload("res://scenes/gui/storage_cell.tscn")
@export var resource = preload("res://resources/objects/storage1_resource.tres")

func _ready() -> void:
	print("ready")
	self.number_of_cells = resource.num_of_cells
	spawn_cells()

func _process(delta: float) -> void:
	pass

func spawn_cells():
	print("Number of cells: ", number_of_cells)
	for i in range(number_of_cells):
		print(i)
		self.add_child(cell.instantiate())
	# Setting id for each cell
	for i in range(number_of_cells):
		get_child(i).id = i

func get_resource():
	return self.resource

func _input(event: InputEvent) -> void:
	pass
