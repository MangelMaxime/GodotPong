extends Control
class_name UIScene

onready var new_game_button : Button = $"CenterContainer/VBoxContainer/New game"
onready var resume_button : Button = $CenterContainer/VBoxContainer/Resume
onready var about_button : Button = $CenterContainer/VBoxContainer/About
onready var quit_button : Button = $CenterContainer/VBoxContainer/Quit
onready var winner_label : RichTextLabel = $"CenterContainer/VBoxContainer/Winner text"
onready var bip_sound_player : AudioStreamPlayer2D = $BipSound

const about_scene := preload("res://About.tscn")

# Variable used to detect first load of the menu
# Allow us to avoid playing a bip when starting the game
# It was feeling weird
var first_load = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.setup_start_menu()

func _on_Quit_pressed():
	bip_sound_player.play()
	get_tree().quit()

func _on_New_game_pressed():
	bip_sound_player.play()
	get_tree().reload_current_scene()
	get_tree().paused = false

func setup_pause_menu():
	$".".show()
	# Setup button visibility
	new_game_button.hide()
	resume_button.show()
	about_button.hide()
	winner_label.hide()
	# Focus the initial menu item
	resume_button.grab_focus()
	# Update focus links so the menu works as expected
	quit_button.focus_previous = resume_button.get_path()
	
func setup_start_menu():
	$".".show()
	# Setup button visibility
	new_game_button.show()
	resume_button.hide()
	about_button.show()
	winner_label.hide()
	# Focus the initial menu item
	new_game_button.grab_focus()
	# Update focus links so the menu works as expected
	quit_button.focus_previous = about_button.get_path()

func setup_win_menu(text : String):
	var bbcode_text = "[center][wave amp=60 freq=3]%s[/wave][/center]" % [text]
	winner_label.bbcode_text = bbcode_text
	
		# Setup button visibility
	new_game_button.show()
	resume_button.hide()
	about_button.show()
	winner_label.show()
	# Focus the initial menu item
	new_game_button.grab_focus()
	# Update focus links so the menu works as expected
	quit_button.focus_previous = about_button.get_path()

func _on_Resume_pressed():
	bip_sound_player.play()
	$".".hide()
	get_tree().paused = false


func _on_About_pressed():
	bip_sound_player.play()
	$".".hide()
	get_tree().root.add_child(about_scene.instance())


func _on_ui_element_focus_entered():
	if first_load:
		first_load = false
	else:
		bip_sound_player.play()
