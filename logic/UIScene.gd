extends Control

func _input(event : InputEvent):
	# Only listen to input if the game is paused
	if get_tree().paused and event is InputEventKey:
		if event.scancode == KEY_ENTER:
			get_tree().reload_current_scene()
			get_tree().paused = false