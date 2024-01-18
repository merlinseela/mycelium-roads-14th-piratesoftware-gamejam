extends Node2D

# game_speed 1 means 6 mins for 1 day then 6 for 1 night
var game_speed = 1
var tweenfade : Tween
var game_time = 0
#Allows reuse of confirm menu
var going_to_main_menu : bool = false

func _process(_delta):
	# game quit button called by "escape"-key
	if Input.is_action_just_pressed("ui_cancel"):
		if $Options.visible == true:
			$AudioBack.play()
		elif $Options.visible == false:
			$AudioConfirm.play()
		$Options.visible = !$Options.visible

	#Keeping track of time played for other UI later
	game_time += _delta
	
	#Rotates the sun around weather
	%SunMoonMovement.rotation_degrees += _delta * game_speed
	#Counter rotates the sun to keep the same rotation
	%SunMoon.rotation_degrees -= _delta * game_speed

	#Rotation tracker to see when the sun/moon is at the top again
	if %SunMoonMovement.rotation_degrees >= 0:
		%SunMoonMovement.rotation_degrees = -360

		#Does the fade in and out of the sun
		tweenfade = create_tween()
		tweenfade.tween_property(%SunMoon, "modulate:a", 0.0, 2)
		tweenfade.tween_callback(_change_sun)
		tweenfade.tween_property(%SunMoon, "modulate:a", 1.0, 2)

#Changes the sun to moon and back
func _change_sun():
	if %SunMoon.frame == 0:
		%SunMoon.frame = 1
	else:
		%SunMoon.frame = 0
	print_debug(game_time)

#Quits the app
func _on_quit_button_pressed():
	$AudioConfirm.play()
	%HBoxConfirm.visible = true
	%VBoxOptions.visible = false

#Opens the confirmation menu
func _on_button_main_menu_pressed():
	$AudioConfirm.play()
	going_to_main_menu = true
	%HBoxConfirm.visible = true
	%VBoxOptions.visible = false

#Goes back to the options menu
func _on_button_decline_pressed():
	$AudioBack.play()
	going_to_main_menu = false
	%HBoxConfirm.visible = false
	%VBoxOptions.visible = true

#Goes to main_scene or quits game depending on what button opened this menu
func _on_button_confirm_pressed():
	if going_to_main_menu == true:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	elif  going_to_main_menu == false:
		get_tree().quit()

#Hides options and gets back to the game
func _on_button_back_pressed():
	$AudioBack.play()
	$Options.visible = false
