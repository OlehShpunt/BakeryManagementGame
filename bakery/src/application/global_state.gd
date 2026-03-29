class_name GlobalState
extends RefCounted

var _current_selected_cell_state: CellState

var current_selected_cell_state: CellState:
	set(state):
		print("setting new state")
		_current_selected_cell_state = state
	get():
		return _current_selected_cell_state


func _ready() -> void:
	PresentationEventBus.deselect_all_cells.connect(_on_deselect_all_cells)


func _on_deselect_all_cells() -> void:
	pass
