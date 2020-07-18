extends Area2D

var MOVE_SPEED = 150

onready var Ball : Ball = get_node("../Ball")

func _ready():
	position.y = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Ball.direction.x < 0:
		position.y = Ball.position.y
	else:
		if position.y < 300:
			position.y = clamp(position.y + MOVE_SPEED * delta, 0, 300)
		else:
			position.y = clamp(position.y - MOVE_SPEED * delta, 300, 600)

func _on_area_entered(area):
	if area.name == "Ball":
		area.bounce(1)
