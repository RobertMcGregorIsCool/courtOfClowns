extends Node3D

@onready var min_z = $MinZ #Node3Ds in world that define acceptable teleportation volume/destination.
@onready var max_z = $MaxZ
@onready var min_x = $MinX
@onready var max_x = $MaxX

# Courtiers call this function for teleportation destination and next waypoint for wandering.
func get_destination():
	var destinationX : float = randf_range(min_x.position.x, max_x.position.x)
	var destinationZ : float = randf_range(min_z.position.z, max_z.position.z)
	return Vector2(destinationX, destinationZ)# Should really have made this Vec3D, why not?
