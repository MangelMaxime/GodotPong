extends Area2D

export var scoreReference = "Left"

var score : Scoreboard

# Called when the node enters the scene tree for the first time.
func _ready():
	var scorePath = "../" + scoreReference + "Scoreboard"
	score = get_node(scorePath)

func _on_area_entered(area):
	if area.name == "Ball":
		score.increment()
