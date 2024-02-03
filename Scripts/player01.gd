extends CharacterBody3D

const MOVE_SPEED : float = 4.0

#const gravity : float = 20.0

var facing_angle : float = 0.0;

@onready var model : Node3D = get_node("humanScaleReference01001RS") #Finds player model on path

enum PLAYER_NUM {p1,p2} # Apparently enums get SCREAMING_SNAKE consts
@export var player_Number : PLAYER_NUM = PLAYER_NUM.p1

func _physics_process(delta):
	var plyr : String = PLAYER_NUM.keys()[player_Number] #Script reuse for two players, see below
	var input = Input.get_vector(plyr + "_move_lft", plyr + "_move_rgt", plyr + "_move_fwd", plyr + "_move_bck")
	
	var dir = Vector3 (input.x, 0, input.y) #Create movement dir from input
	velocity = dir * MOVE_SPEED #Velocity is a property from CharacterBody3D 
	
	move_and_slide()# Execute physics input (eg. velocity)
	
	if input.length() > 0:# If there's input from the sticks/keys...
		facing_angle = Vector2(input.y, input.x).angle();# Returns angle w/respect to pos X, or (1, 0) vec, in rads.
	
		model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.5)# Rotate modl to face targ dir, 50% per loop
