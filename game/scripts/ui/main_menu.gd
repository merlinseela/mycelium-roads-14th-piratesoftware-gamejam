extends Control

var title_tween :Tween
var save_file

#Simple tween to make the title wiggle.
func _ready():
	title_tween = create_tween()
	%GameTitle.set_pivot_offset(%GameTitle.size / 2)
	title_tween.tween_property(%GameTitle, "rotation", .15, 5)
	title_tween.tween_callback(_title_wiggle)

func _title_wiggle():
	title_tween.stop()
	title_tween = create_tween().set_loops()
	title_tween.tween_property(%GameTitle, "rotation", -.15, 10)
	title_tween.tween_property(%GameTitle, "rotation", .15, 10)
	
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

#Sets the slot the game should be saved to
func _on_button_slot_1_pressed():
	save_file = 1
	get_tree().change_scene_to_file("res://main.tscn")

func _on_button_slot_2_pressed():
	save_file = 2
	get_tree().change_scene_to_file("res://main.tscn")

func _on_button_slot_3_pressed():
	save_file = 3
	get_tree().change_scene_to_file("res://main.tscn")
