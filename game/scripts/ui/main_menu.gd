extends Control

var title_tween :Tween
var save_file

#Simple tween to make the title wiggle.
func _ready():
	title_tween = create_tween().set_loops()
	%GameTitle.set_pivot_offset(%GameTitle.size / 2)
	title_tween.tween_property(%GameTitle, "rotation", .15, 10)
	title_tween.tween_property(%GameTitle, "rotation", -.15, 10)
	
func _process(_delta):
	pass

#Hide/show save slots with sound effects
func _on_button_new_game_pressed():
	if %VBoxSlots.visible == true:
		$AudioBack.play()
	elif %VBoxSlots.visible == false:
		$AudioConfirm.play()
	%VBoxSlots.visible = !%VBoxSlots.visible

#Quits the app
func _on_button_quit_pressed():
	get_tree().quit()
