tool
extends Node2D
class_name Scoreboard

export var max_score = 5
export var offset = Vector2(0,0)
export var size = Vector2(512,20)
export var player_name = ""

const score_slot = preload("res://ScoreSlot.tscn")

var current_score = 0

func _ready():
	if not Engine.editor_hint:
		for center in get_centers():
			var new_score_slot = score_slot.instance()

			new_score_slot.position.x = center.x
			new_score_slot.position.y = center.y

			$Sockets.add_child(new_score_slot)

# Return a list of Vector2 representing the center where to place the
# scoreboard icons
func get_centers():
	var res = []
	var socket_y = offset.y + size.y / 2
	var socket_x_step = size.x / (max_score + 1)

	for index in range(max_score):
		var x = offset.x + socket_x_step + socket_x_step * index
		var y = socket_y
		res.append(Vector2(x, y))
	return res

func _draw():
	if Engine.editor_hint:
		var a = Vector2(offset.x, offset.y)
		var b = Vector2(offset.x + size.x, offset.y)
		var c = Vector2(offset.x + size.x, offset.y + size.y)
		var d = Vector2(offset.x, offset.y + size.y)

		draw_line(a, b, Color.red)
		draw_line(b, c, Color.red)
		draw_line(c, d, Color.red)
		draw_line(d, a, Color.red)

		for center in get_centers():
			draw_circle(center, 8, Color.red)

func increment():
	$Sockets.get_child(current_score).set_active()
	current_score += 1

	if current_score == max_score:
		print("Player %s win!" % player_name)
		pass

func decrement():
	current_score -= 1