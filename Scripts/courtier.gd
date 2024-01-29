extends CharacterBody3D


var destination_setter = null
#var destination : vector2 = new(Vector2)

var destination2d : Vector2
var destination3d : Vector3
var facing_angle : float = 0.0;

const RAY_LENGTH = 1000

@export var timer : float = 0.0
@export var alarm : float = 5.0

@export var headingLength : float
@export var headLengthThreshold : float = 1.0
@export var move_speed : float = 1.0
@export var walk_speed : float = 1.0
@export var chase_speed: float = 2.0

var target_player : CharacterBody3D = null
var chaseMode : bool = false;

@export var timerChase : float = 0.0
@export var alarmChase : float = 10.0

@onready var model : Node3D = get_node("humanScaleReference01001RS")

func _ready():
	var container = get_tree().get_nodes_in_group("Destination-Setter")
	if !container.is_empty():
		destination_setter = container.front()
	global_position = _get_destination3d()
	
	var playerContainer = get_tree().get_nodes_in_group("Players")

func _physics_process(delta):
	_plotAndMove(delta)
	
	if(chaseMode):
		timerChase += delta;
		if(timerChase > alarmChase):
			chaseMode = false
			timerChase = 0
			move_speed = walk_speed
			destination3d = _get_destination3d()
	
	var space_state = get_world_3d().direct_space_state
	var origin : Vector3 = global_position + Vector3.UP
	var end : Vector3 = origin + global_transform.basis.z * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end);
	query.collide_with_areas = true
	var result : Dictionary = space_state.intersect_ray(query)

func _plotAndMove(delta : float):
	var heading : Vector3 = destination3d - global_position
	
	headingLength = _squared_magnitude(heading)
	
	if(headingLength < headLengthThreshold || timer > alarm): #This should also have a timer.
		if(chaseMode):
			destination3d = target_player.global_position
		else:
			destination3d = _get_destination3d()

		timer = 0.0
	else:

		timer += delta
		var headingNormalized : Vector3 = heading / sqrt(headingLength)
		velocity = move_speed * headingNormalized;
	move_and_slide()
	
	if headingLength > 0:
		facing_angle = Vector2(destination3d.z, destination3d.x).angle();
	
		model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.5)

func _get_destination3d():
	destination2d = destination_setter.get_destination()	
	return Vector3(destination2d.x, 0.01, destination2d.y)
	
func _squared_magnitude(vect : Vector3):
	return ((vect.x * vect.x) + (vect.y * vect.y) + (vect.z * vect.z))

func go_chase_mode(playerToChase : CharacterBody3D):
	AudioManager.play_sfx(AudioManager.yelp,{"volume":0})
	AudioManager.play_sfx(AudioManager.laugh,{"volume":0})
	if(!chaseMode):
		chaseMode = true
		move_speed = chase_speed
		print("Chasing!")
		target_player = playerToChase
