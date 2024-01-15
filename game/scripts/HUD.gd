extends Node2D

# game_speed 1 means 6 mins for 1 day then 6 for 1 night
var game_speed = 1
var tweenfade : Tween
var game_time = 0

func _process(_delta):
	# game quit button called by "escape"-key
	if Input.is_action_just_pressed("ui_cancel"):
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
