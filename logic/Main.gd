extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ball.set_process(false)
	
	if Global.first_load:
		get_tree().paused = true
		Global.first_load = false
	else:
		$UILayer.hide()

func _process(_delta):
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		$UILayer.show()
		$UILayer/UI.setup_pause_menu()

func _on_Delay_animation_finished(anim_name):
	$Ball.set_process(true)
	$Ball.reset()

func _input(_event):
	if OS.is_debug_build():
		if Input.is_key_pressed(KEY_R):
			get_tree().reload_current_scene()
