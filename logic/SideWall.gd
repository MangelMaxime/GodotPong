extends Area2D

export var scoreReference = "Left"

var score : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var scorePath = "../" + scoreReference + " Score"
	score = get_node(scorePath)

func _on_area_entered(area):
	if area.name == "Ball":
		var newScore = int(score.text) + 1
		score.text = str(newScore)

		var ball := area as Ball
		ball.reset()
