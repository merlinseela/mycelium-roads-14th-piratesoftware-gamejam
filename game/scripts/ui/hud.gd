extends Node2D

# game_speed 1 means 6 mins for 1 day then 6 for 1 night
var game_speed
var new_game_speed
var tweenfade : Tween
var game_time = 0

@onready var option_vars = get_node("/root/Options")

signal update_game_speed

func _ready():
	%SliderVolume.set_value(option_vars.music_volume)
	$AudioMain.play()
	$AudioMain.volume_db = option_vars.music_volume - 50

func _process(_delta):
	#options menu controls called by "escape"-key
	if Input.is_action_just_pressed("ui_cancel"):
		if $Options.visible == true and %VBoxConfirm.visible == false:
			$AudioBack.play()
			$Options.visible = !$Options.visible
		elif $Options.visible == false and %VBoxConfirm.visible == false:
			$AudioConfirm.play()
			$Options.visible = !$Options.visible
		elif %VBoxOptions.visible == false and %VBoxConfirm.visible == true:
			$AudioBack.play()
			%VBoxConfirm.visible = false
			%VBoxOptions.visible = true
	
	#Sets game speed based on what button is pressed
	if %ButtonPause.is_pressed() == true or $RandomEvent.visible == true or $Options.visible == true:
		new_game_speed = 0
	elif %ButtonPlay.is_pressed() == true:
		new_game_speed = 1
	elif %Button2x.is_pressed() == true:
		new_game_speed = 2
	elif %Button3x.is_pressed() == true:
		new_game_speed = 3
	
	#Checks if the game speed has changed and emits a signal if it has
	if new_game_speed != game_speed:
		game_speed = new_game_speed
		update_game_speed.emit(new_game_speed)

	#Keeping track of time played for other UI later
	game_time += _delta
	
	#Rotates the sun around weather
	if %SunMoon.frame == 0 and %SunMoonMovement.rotation_degrees < -270:
		%SunMoonMovement.rotation_degrees += _delta * game_speed * .25
		#Counter rotates the sun to keep the same rotation
		%SunMoon.rotation_degrees -= _delta * game_speed * .25
	elif %SunMoon.frame == 1 and %SunMoonMovement.rotation_degrees > -360:
		%SunMoonMovement.rotation_degrees -= _delta * game_speed * .25
		%SunMoon.rotation_degrees += _delta * game_speed * .25

	#Rotation tracker to see when the sun/moon is at the top again
	if %SunMoonMovement.rotation_degrees > -270:
		%SunMoonMovement.rotation_degrees = -270
		_tween_sun()
	if %SunMoonMovement.rotation_degrees < -360:
		%SunMoonMovement.rotation_degrees = -360
		_tween_sun()
	
	#Makes audio loop
	if $AudioMain.is_playing == false:
		$AudioMain.play()

func _change_sun():
	#Changes the sun to moon and back
	if %SunMoon.frame == 0:
		%SunMoon.frame = 1
	else:
		%SunMoon.frame = 0
	
func _tween_sun():
	#Does the fade in and out of the sun
	print_debug(game_time)
	tweenfade = create_tween()
	tweenfade.tween_property(%SunMoon, "modulate:a", 0.0, 2)
	tweenfade.tween_callback(_change_sun)
	tweenfade.tween_property(%SunMoon, "modulate:a", 1.0, 2)

#Quits the app
func _on_quit_button_pressed():
	$AudioConfirm.play()
	%LabelConfirmation.text = "Quit game?"
	%VBoxConfirm.visible = true
	%VBoxOptions.visible = false

#Opens the confirmation menu
func _on_button_main_menu_pressed():
	$AudioConfirm.play()
	%LabelConfirmation.text = "Go to main menu?"
	%VBoxConfirm.visible = true
	%VBoxOptions.visible = false

#Goes back to the options menu
func _on_button_decline_pressed():
	$AudioBack.play()
	%VBoxConfirm.visible = false
	%VBoxOptions.visible = true

#Goes to main_scene or quits game depending on what button opened this menu
func _on_button_confirm_pressed():
	if %LabelConfirmation.text == "Go to main menu?":
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
	elif  %LabelConfirmation.text == "Quit game?":
		get_tree().quit()

#Hides options and gets back to the game
func _on_button_back_pressed():
	$AudioBack.play()
	$Options.visible = false

func _on_button_options_pressed():
	$Options.visible = !$Options.visible
	$AudioConfirm.play()

func _on_slider_volume_value_changed(value):
	if value == 10:
		$AudioMain.volume_db = -100
	else:
		$AudioMain.volume_db = value - 50
	Options._on_value_changed(value)
