class_name LocationEventListener
extends Node

@onready var street_packed_scene: PackedScene = load(PathHolder.STREET_PATH)


func _ready() -> void:
	EventBus.load_street_location.connect(_on_load_street_location)

	print("[DEV][P] LocationEventListener initialized")


func _on_load_street_location():
	var tree = get_tree()
	var street_instance = street_packed_scene.instantiate()
	tree.root.add_child(street_instance)
	tree.current_scene = street_instance

	print("[DEV][P] Responded to \"EventBus.load_street_location\" - street scene successfully loaded")
