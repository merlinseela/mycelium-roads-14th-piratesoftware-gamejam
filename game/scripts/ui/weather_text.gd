extends Area2D

var current_weather
var current_time
var current_day = 1

func _process(_delta):
	#Checking if it is day or night time
	if %SunMoon.get_frame() == 0:
		current_time = "Day: "
	else:
		current_time = "Night: "
	
	#Checking the current weather
	if %WeatherSprite.get_frame() == 0:
		current_weather = "Sunny"
	elif %WeatherSprite.get_frame() == 1:
		current_weather = "Rainy"
	else:
		current_weather = "Stormy"
		
	#Sets text for time/day/weather
	%LabelWeather.text = (current_time + str(current_day) + "\n" + current_weather)

#Makes current weather and day visible/invisible
func _on_weather_mouse_entered():
	$NineWeather.visible = true
	

func _on_weather_mouse_exited():
	$NineWeather.visible = false

func _on_sun_moon_frame_changed():
	#When the sun gets set it updates the day counter
	if %SunMoon.get_frame() == 0:
		current_day += 1
