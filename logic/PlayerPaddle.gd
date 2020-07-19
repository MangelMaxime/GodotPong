extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var MOVE_SPEED = 275

onready var _screen_size_y = get_viewport_rect().size.y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	position.y = clamp(position.y + input * MOVE_SPEED * delta, 30, _screen_size_y - 30)

func _on_area_entered(area):
	if area.name == "Ball":
		area.bounce(-1)
