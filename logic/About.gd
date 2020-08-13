extends Control

onready var close_button : Button = $Panel/MarginContainer/VBoxContainer/CenterContainer/Close

func _ready():
	close_button.grab_focus()
	
func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		$"/root/Pong/UI".setup_start_menu()
		self.queue_free()


func _on_Close_pressed():
	$"/root/Pong/UI".setup_start_menu()
	self.queue_free()
