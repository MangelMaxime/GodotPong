extends Area2D
class_name Ball

export var SPEED = 200

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

	bounce(horizontalDirection)

	# Reset trail
	$Trail.clear_points()

func bounce(horizontalDirection):
	direction = Vector2(horizontalDirection, randf() * 2 - 1)

func randomRightDirection():
	bounce(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED * direction * delta

func _input(_event):
	if Input.is_key_pressed(KEY_R):
		reset()
