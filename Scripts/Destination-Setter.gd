extends Node3D

@onready var min_z = $MinZ
@onready var max_z = $MaxZ
@onready var min_x = $MinX
@onready var max_x = $MaxX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_destination():
	var destinationX : float = randf_range(min_z.position.z, max_z.position.z)
	var destinationZ : float = randf_range(min_x.position.x, max_z.position.x)
	return Vector2(destinationX, destinationZ)
