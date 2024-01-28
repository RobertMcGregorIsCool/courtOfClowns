extends Node3D

@onready var min_z = $MinZ
@onready var max_z = $MaxZ
@onready var min_x = $MinX
@onready var max_x = $MaxX

func get_destination():
	var destinationX : float = randf_range(min_x.position.x, max_x.position.x)
	var destinationZ : float = randf_range(min_z.position.z, max_z.position.z)
	return Vector2(destinationX, destinationZ)
