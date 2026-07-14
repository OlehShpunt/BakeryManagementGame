class_name MultiplayerPlayerState
extends RefCounted

var id: String = "":
	set(value):
		id = value
	get:
		return id

var name: String = "":
	set(value):
		name = value
	get:
		return name

var location: EnumHolder.Location:
	set(value):
		location = value
	get:
		return location

var position: Vector2 = Vector2():
	set(value):
		position = value
	get:
		return position


func _init(m_p_id: String, m_p_name: String) -> void:
	id = m_p_id
	name = m_p_name
	location = EnumHolder.Location.Street
	position = Vector2(20, 80)
