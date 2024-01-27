extends CharacterBody3D


var destination_setter = null
#var destination : vector2 = new(Vector2)

func _ready():
	var container = get_tree().get_nodes_in_group("Destination-Setter")
	if !container.is_empty():
		destination_setter = container.front()
	
	var destination : Vector2 = destination_setter.get_destination()	
		
	global_position = Vector3(destination.x, 0.01, destination.y)
