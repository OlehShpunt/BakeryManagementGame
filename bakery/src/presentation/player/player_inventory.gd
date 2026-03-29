class_name PlayerInventory
extends Control

@onready var cell_container := $GridContainer
var _cell_ref_registry: Dictionary[int, InventoryCell]
var _current_active_cell: int = -1


func _ready() -> void:
	EventBus.start_game.connect(_on_start_game)
	PresentationEventBus.deselect_all_cells.connect(_on_deselect_all_cells)

	self.hide()

	var count := 0
	var children := cell_container.get_children()
	for child in children:
		if (is_instance_of(child, InventoryCell)):
			var cell: InventoryCell = child as InventoryCell
			cell.id = count
			count += 1

			_cell_ref_registry[cell.id] = cell
			cell.button_pressed.connect(_on_cell_button_pressed)

	StateManager.get_player_state().init_player_inventory(count)


func _on_start_game() -> void:
	self.show()


func _on_cell_button_pressed(cell_id: int) -> void:
	var current_active_cell := _current_active_cell # NOTE: Need a copy, since _current_active_cell is modified right after this statement
	PresentationEventBus.deselect_all_cells.emit()

	select_cell(cell_id)


func _on_deselect_all_cells() -> void:
	if (_current_active_cell != -1):
		deselect_cell(_current_active_cell)


func deselect_cell(cell_id: int) -> void:
	var cell: InventoryCell = _cell_ref_registry.get(cell_id)
	_current_active_cell = -1
	cell.hide_border()


func select_cell(cell_id: int) -> void:
	var cell: InventoryCell = _cell_ref_registry.get(cell_id)
	_current_active_cell = cell_id
	cell.show_border()
