extends CharacterBody3D

const move_speed : float = 4.0
const jump_speed : float = 8.0

const gravity : float = 20.0

var facing_angle : float = 0.0;

@onready var model : Node3D = get_node("humanScaleReference01001RS")

func _physics_process(delta):
	var input = Input.get_vector("p1_move_lft", "p1_move_rgt", "p1_move_fwd", "p1_move_bck")
	
	var dir = Vector3 (input.x, 0, input.y)
	velocity = dir * move_speed
	move_and_slide()
