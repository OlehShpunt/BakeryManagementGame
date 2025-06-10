class_name npc_base
extends Node2D


@export var movement_speed: float = 50.0
@onready var navigation_agent: NavigationAgent2D = get_node("NavigationAgent2D")
var movement_delta: float
## Used on instance creation before adding to a scene to specify initial NPC spawn position
var buffered_target_position : Vector2 = Vector2.ZERO
@onready var npc_current_location_path = path_holder.STREET_PATH


func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	if buffered_target_position != Vector2.ZERO:
		navigation_agent.target_position = buffered_target_position
	else:
		push_warning("buffered_target_position is ZERO")
	
	player_location_lists.locations_changes.connect(on_player_location_changed)


func set_target_position(new_target_position: Vector2):
	navigation_agent.set_target_position(new_target_position)


func _physics_process(delta):
	print("()() ", global_position)
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

	movement_delta = movement_speed * delta
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_delta
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)


## Called when the playern or self changes location
## Hide or show self if in same location as player
func on_player_location_changed(location_list):
	print("*** called on loc changed")
	
	# TODO lambda for deferred_call()
	
	call_deferred("deferred_call", location_list)
# TODO lambda
func deferred_call(location_list):
	var current_location_path : String = get_tree().current_scene.get_location_path()
	
	print("*** current_location_path = ", current_location_path)
	
	if location_list[npc_current_location_path].has(get_multiplayer_authority()):
		self.show()
		print("*** showing npc")
	else:
		self.hide()
		print("*** hiding npc")
