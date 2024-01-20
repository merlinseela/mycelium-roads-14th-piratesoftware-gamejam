extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# move
	if Input.is_action_just_pressed("mouse_right_button"):
		$mushy.position = get_viewport().get_mouse_position()
		print()
	
	
