extends CharacterBody2D

const SPEED = 3.0
var game_on: bool

func _ready() -> void:
	$"/root/main/WinLabel".visible = false
	game_on = true

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()  

func _physics_process(delta: float) -> void:
	var screen_size = get_viewport_rect().size / $"/root/main/Camera2D".zoom
	
	var sprite_size =  $CollisionShape2D.shape.radius
	
	var movement := Vector2.ZERO
	
	if game_on:
		if Input.is_action_pressed("ui_left"):
			movement.x = SPEED * -1
			$AnimatedSprite2D.animation = "left"
			$AnimatedSprite2D.play()
		elif Input.is_action_pressed("ui_right"):
			movement.x = SPEED
			$AnimatedSprite2D.animation = "right"
			$AnimatedSprite2D.play()
		elif Input.is_action_pressed("ui_down"):
			movement.y = SPEED 
			$AnimatedSprite2D.animation = "down"
			$AnimatedSprite2D.play()
		elif Input.is_action_pressed("ui_up"):
			movement.y = SPEED * -1
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
			
		move_and_collide(movement)
	else:
		$AnimatedSprite2D.stop()
		
	# Clamp position to screen bounds
	position.x = clamp(position.x, sprite_size, screen_size.x - sprite_size)
	position.y = clamp(position.y, sprite_size, screen_size.y  - sprite_size)

func _on_goal_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	$"../WinLabel".visible = true
	game_on = false
