extends RigidBody3D

func _ready():
	pass
	
func _on_body_entered(body):
	if (body.name == "goal"):
		print("score!")
