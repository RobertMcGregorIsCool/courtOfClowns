extends RayCast3D

enum CHAR_TYPE { npc, p1, p2 }

@export var char_type : CHAR_TYPE = CHAR_TYPE.npc

var facing_angle : float = 0.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var plyr : String = CHAR_TYPE.keys()[char_type]
	
	if(char_type != CHAR_TYPE.npc): # I think this is from when I didn't know if all characters would inherit this raycast.
		if(is_colliding()):
			var container : Array[Node] = get_tree().get_nodes_in_group("courtiers") # Get objects with tag, should probably do earlier
			if !container.is_empty():
				var candidate : Object = get_collider()
				if(container.has(candidate)):
					if(Input.is_action_pressed(plyr + "_do")):# If cast collides with valid candidate AND press 'do'
						candidate.go_chase_mode(get_parent())# Send the candidate the player object!
	
	# Recreate turning code as I'm fighting inheritance and not composition! (Ideally this Raycast3D object should
	# be in the Player01 scene (same scene I'm using for Courtiers! =/ ) OR should pass rotation info from player01
	# to this. Need to plan this better.
	var input = Input.get_vector(plyr + "_move_lft", plyr + "_move_rgt", plyr + "_move_fwd", plyr + "_move_bck")
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle();
	
		var currentRot : Vector3 = get_global_rotation()
		
		rotation = Vector3(currentRot.x, lerp_angle(currentRot.y, facing_angle, 0.5), currentRot.z)	
	pass
