extends Area2D

export var bounce_direction = 1

func _on_area_entered(area : Area2D):
	if area.name == "Ball":
		area.bounce_off_wall(bounce_direction)
		
