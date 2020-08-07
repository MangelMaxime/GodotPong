extends Area2D
class_name Ball

export var SPEED = 250

onready var _speed = SPEED
var direction

func _ready():
	randomize()
	reset()

func reset():
	# Reset to the center of the viewport
	var viewport = get_viewport_rect().size
	position = Vector2(viewport.x / 2, viewport.y / 2)

	# Randomize the initial direction
	var horizontalDirection

	if randf() < 0.5:
		horizontalDirection = 1
	else:
		horizontalDirection = -1

	direction = Vector2(horizontalDirection, randf() * 2 - 1)

	# Reset trail
	$Trail.clear_points()

func bounce(paddleCenter : Vector2, horizontalDirection : int):
	# Bounce against paddle logic
	# If the paddle is static and the ball doesn't hit one of the edge
	# reflect the ball like if it was boucing against a wall
	# Increase the speed normally

	# If the paddle is moving and the ball doesn't hit one of the edge
	# reflect the ball in the direction of the paddle movement
	# Increase the speed normally

	# If the ball hit one of the edge bounce the ball at a steep angle and a bigger speed increase
	if self.position.y > paddleCenter.y:
		direction = Vector2(horizontalDirection, 0.5)
	else:
		direction = Vector2(horizontalDirection, -0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED * direction * delta

func _input(_event):
	if Input.is_key_pressed(KEY_R):
		reset()
