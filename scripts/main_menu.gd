extends Control

@onready var quit__button_ = $"MarginContainer/Menu (HBoxContainer)/VBoxContainer/Quit (Button)"
@onready var menu__h_box_container_ = $"MarginContainer/Menu (HBoxContainer)"
@onready var options__h_box_container_ = $"MarginContainer/Options (HBoxContainer)"
@onready var return__button_ = $"MarginContainer/Options (HBoxContainer)/VBoxContainer/Return (Button)"
@onready var online__h_box_container_ = $"MarginContainer/Online (HBoxContainer)"
@onready var online_return__button_ = $"MarginContainer/Online (HBoxContainer)/VBoxContainer/Return (Button)"
@onready var tbd__h_box_container_ = $"MarginContainer/TBD (HBoxContainer)"
@onready var tbd__label_ = $"MarginContainer/TBD (HBoxContainer)/TBD (Label)"

var menu_level : int = 0 # main = 0, options = 1, online = 2, tbd = 5
var last_level : int = 0 # for tbd toggling

func _ready():
	_on_volume_slider_value_changed(0.25, 0)

func _process(delta):
	pass
	
func _input(event):
	# Escape is held down
	if event.is_action_pressed("escape"):
		match menu_level:
			0: # main menu
				quit__button_.button_pressed = true
			1: # options
				return__button_.button_pressed = true
			2: # online choices
				online_return__button_.button_pressed = true
	# Escape is released
	if event.is_action_released("escape"):
		match menu_level:
			0: # main menu
				_on_quit_button_button_up()
			1: # options
				return_to_menu()
			2: # online choices
				return_to_menu()
			5: # tbd message
				match last_level:
					0:
						tbd__h_box_container_.visible = false
						menu__h_box_container_.visible = true
						menu_level = 0
					2:
						tbd__h_box_container_.visible = false
						online__h_box_container_.visible = true
						menu_level = 2

# Returning to main menu
func return_to_menu():
	options__h_box_container_.visible = false
	online__h_box_container_.visible = false
	menu__h_box_container_.visible = true
	menu_level = 0
	return__button_.toggle_mode = false
	online_return__button_.toggle_mode = false

# Play Online button pressed
func _on_play_online_button_button_up():
	menu__h_box_container_.visible = false
	online__h_box_container_.visible = true
	menu_level = 2
	online_return__button_.toggle_mode = true

# Ranked button pressed
func _on_ranked_button_button_up():
	tbd__label_.text = "Ranked mode is in development.\nPress ESC to return."
	toggle_tbd(2)

# Unranked button pressed
func _on_unranked_button_button_up():
	tbd__label_.text = "Unranked mode is in development.\nPress ESC to return."
	toggle_tbd(2)

# Direct button pressed
func _on_direct_button_button_up():
	tbd__label_.text = "Direct mode is in development.\nPress ESC to return."
	toggle_tbd(2)

# Tutorial button pressed
func _on_tutorial_button_button_up():
	tbd__label_.text = "Tutorial mode is in development.\nPress ESC to return."
	toggle_tbd(0)

# Show temporary TBD message
func toggle_tbd(level):
	last_level = level
	menu__h_box_container_.visible = false
	online__h_box_container_.visible = false
	tbd__h_box_container_.visible = true
	menu_level = 5

# Options button pressed
func _on_options_button_button_up():
	menu__h_box_container_.visible = false
	options__h_box_container_.visible = true
	menu_level = 1
	return__button_.toggle_mode = true

# Quit button pressed
func _on_quit_button_button_up():
	get_tree().quit()

# Return button pressed, from options or online
func _on_return_button_button_up():
	return_to_menu()

# Volume sliders adjusted
func _on_volume_slider_value_changed(value, index):
	AudioServer.set_bus_volume_db(
		index, 
		linear_to_db(value) # convert 0-1 to db values
	)

# Display option selected
func _on_display_option_button_item_selected(index):
	#0 = Fullscreen, 1 = Windowed Fullscreen
	DisplayServer.window_set_mode(4-index*2)
