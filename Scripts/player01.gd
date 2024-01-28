extends CharacterBody3D

const move_speed : float = 4.0
const jump_speed : float = 8.0

const gravity : float = 20.0

var facing_angle : float = 0.0;

@onready var model : Node3D = get_node("humanScaleReference01001RS")

enum PLAYER_NUM {p1,p2}

@export var player_Number : PLAYER_NUM = PLAYER_NUM.p1

func _physics_process(delta):
	var plyr : String = PLAYER_NUM.keys()[player_Number]
	var input = Input.get_vector(plyr + "_move_lft", plyr + "_move_rgt", plyr + "_move_fwd", plyr + "_move_bck")
	
	var dir = Vector3 (input.x, 0, input.y)
	velocity = dir * move_speed
	
	move_and_slide()
	
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle();
	
		model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.5)
