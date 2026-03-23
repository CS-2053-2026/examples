extends CharacterBody3D

var speed:int = 6
var push_force:int = 6

func _physics_process(delta: float) -> void:
	# Returns -1 if left is pressed, 1 if right is pressed, or 0 if neither/both
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = horizontal_direction * speed
	
	var verical_direction = Input.get_axis("ui_up", "ui_down")
	velocity.z = verical_direction * speed
	
	move_and_slide()

	# Manually handle pushing RigidBodies
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			# Direction of the push (opposite of the collision normal)
			var push_dir = -collision.get_normal()
			
			# Use apply_central_impulse to "kick" the object
			# Higher push_force makes you feel heavier
			collider.apply_central_impulse(push_dir * push_force)
