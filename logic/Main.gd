extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.first_load:
		get_tree().paused = true
		Global.first_load = false
	else:
		$UI.hide()
