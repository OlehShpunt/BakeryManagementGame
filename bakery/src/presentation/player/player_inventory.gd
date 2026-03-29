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
			var new_cell_state := CellState.new()
			cell.cell_state = new_cell_state
			print("cell.cell_state = ", cell.cell_state)
			StateManager.get_player_state().register_cell_state(count, new_cell_state)
			count += 1

			_cell_ref_registry[cell.id] = cell
			cell.button_pressed.connect(_on_cell_button_pressed)
		else:
			print("[DEBUG] child is not an instance of InventoryCell")


func _on_start_game() -> void:
	self.show()


func _on_cell_button_pressed(cell_id: int) -> void:
	var inventory_cell_state_to_select: CellState = StateManager.get_player_state().get_cell_state(cell_id)

	# If pressed cell is already selected
	var previous_selected_cell_state := StateManager.get_global_state().current_selected_cell_state
	if (previous_selected_cell_state == inventory_cell_state_to_select):
		print("pressed cell is already selected")
		deselect_cell(cell_id)
		StateManager.get_global_state().current_selected_cell_state = null
		return

	# Is any cell already selected?
	if (previous_selected_cell_state != null):
		# Is the destination cell empty?
		if (inventory_cell_state_to_select.item == null):
			# Does the previous selected cell store an item?
			if (previous_selected_cell_state.item != null):
				# If so, move the current selected item to the selected cell's state

				var item_copy := Item.new(StateManager.get_global_state().current_selected_cell_state.item.item_code)

				previous_selected_cell_state.item = null

				# Put the item in the destination cell state
				var dest_cell_state := inventory_cell_state_to_select
				dest_cell_state.item = item_copy
				# Update global state's current selected item
				StateManager.get_global_state().current_selected_cell_state = dest_cell_state

	# NOTE: Event listeners do the following:
	# 1. Set current selected item in global_state.gd to null
	# 2. Deselect active cell UI, without changing data or clearing textures
	PresentationEventBus.deselect_all_cells.emit()

	StateManager.get_global_state().current_selected_cell_state = inventory_cell_state_to_select
	select_cell(cell_id)


func _on_deselect_all_cells() -> void:
	if (_current_active_cell != -1):
		deselect_cell(_current_active_cell)


func deselect_cell(cell_id: int) -> void:
	var cell: InventoryCell = _cell_ref_registry.get(cell_id)
	_current_active_cell = -1
	cell.hide_border()


func select_cell(cell_id: int) -> void:
	print("showing border")
	var cell: InventoryCell = _cell_ref_registry.get(cell_id)
	_current_active_cell = cell_id
	cell.show_border()
