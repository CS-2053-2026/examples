extends CharacterBody2D

var mouse_coords:Vector2 = Vector2.ZERO
var target_angle:float = transform.get_rotation()
var rotation_speed:float = 2*PI
var start_point:Vector2 = Vector2.ZERO
var end_point:Vector2 = Vector2.ZERO

# called when an input event occurs
func _input(event):
	if event is InputEventMouseButton:
		# if the mouse button was pressed down
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			target_angle = rotation + get_target_angle()	
			draw_arrow(global_transform.get_origin(), get_global_mouse_position())

			

# called on a scheduled tick... used for calculating movements
func _physics_process(delta: float) -> void:	
	#rotation = rotate_toward(rotation, target_angle, rotation_speed * delta)
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)

# calculates the target angle to rotate towards
func get_target_angle() -> float:
	mouse_coords = get_global_mouse_position()
	
	# position of the character
	var guy_position:Vector2 = global_transform.get_origin()
	
	# get the vector pointing from the characters position towards the mouse
	var new_lookat:Vector2 = (mouse_coords - guy_position).normalized()
	
	# the current vector that the character is "looking at"
	var current_lookat:Vector2 = global_transform.x
	
	# calculate the angle in radians for the rotation
	var rotation_angle:float = acos(new_lookat.dot(current_lookat))
	
	# determine if the rotation is clockwise or counter clockwise
	var rotation_direction:float = new_lookat.cross(current_lookat) 
	
	if rotation_direction > 0:
		rotation_angle *= -1	
	
	return rotation_angle

# draw an arrow to illustrate the facing
func draw_arrow(start:Vector2, end:Vector2):
	#set properties to redraw from the root node
	get_parent().end_point = end
	get_parent().start_point = start
	get_parent().queue_redraw()
