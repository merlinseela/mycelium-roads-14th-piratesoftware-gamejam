extends Camera2D

var speed = 20

func _process(delta):

	var input_x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var input_y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	var input_zoom = int(Input.is_action_pressed("mouse_wheel_down")) - int(Input.is_action_pressed("mouse_wheel_up"))
	
	position.x = lerp(position.x, position.x + input_x * speed, speed * delta)
	position.y = lerp(position.y, position.y + input_y * speed, speed * delta)
	zoom.x = lerp(zoom.x, zoom.x + input_zoom * speed, speed * delta)
