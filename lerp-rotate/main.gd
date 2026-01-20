extends Node2D

var start_point:Vector2 = Vector2.ZERO
var end_point:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(start_point, end_point)
	pass

# called when a redraw has been queued
# draws an arrow from start point to end point
func _draw():
	var color = Color.RED
	var line_width = 2.0
		
	draw_line(start_point, end_point, color, line_width)

	# Optional: Draw a small triangle/arrowhead for clarity
	draw_line(end_point, end_point + (start_point - end_point).normalized().rotated(deg_to_rad(45)) * 10, color, line_width)
	draw_line(end_point, end_point + (start_point - end_point).normalized().rotated(deg_to_rad(-45)) * 10, color, line_width)
