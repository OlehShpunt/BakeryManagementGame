class_name CellArea extends Area2D

func _ready() -> void:
	# There's no is_result_cell variable in cells other than StorageCell
	if get_parent() is StorageCell:
		# Disabling the ability to put items in the result cell (used in cooking gui result cell)
		if get_parent().is_result_cell:
			monitorable = false
			monitoring = false

func get_cell():
	return get_parent()
