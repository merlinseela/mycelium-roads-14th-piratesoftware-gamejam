extends Node2D

# game_speed 1 means 6 mins for 1 day then 6 for 1 night
var game_speed = 1
var tweenfade : Tween
var game_time = 0

func _ready():
	pass
	#$UI/Minimap/SubViewportContainer/SubViewport/mushy/mushy_script/Camera2D.zoom = Vector2(.5,.5)
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
	
	if %ButtonPause.is_pressed() == true:
		game_speed = 0
	elif %ButtonPlay.is_pressed() == true:
		game_speed = 1
	elif %Button2x.is_pressed() == true:
		game_speed = 2
	elif %Button3x.is_pressed() == true:
		game_speed = 3

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
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	elif  %LabelConfirmation.text == "Quit game?":
		get_tree().quit()

#Hides options and gets back to the game
func _on_button_back_pressed():
	$AudioBack.play()
	$Options.visible = false
