extends Node2D

func _process(_delta):
	# game quit button called by "escape"-key
	if Input.is_action_just_pressed("ui_cancel"):
		$Options.visible = !$Options.visible