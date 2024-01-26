extends Control

var title_tween :Tween
var intro_tween :Tween

@onready var option_vars = get_node("/root/Options")
var save_file

func _ready():
	%SliderVolume.set_value(option_vars.music_volume)
	$AudioMain.play()
	$AudioMain.volume_db = option_vars.music_volume - 50
	
	#Simple tween to make the title wiggle.
	title_tween = create_tween()
	title_tween.tween_property(%GameTitle, "rotation", .15, 5)
	title_tween.tween_callback(_title_wiggle)
	
	#Splash screen tween
	intro_tween = create_tween().set_parallel(true)
	intro_tween.tween_property(%LandratLogo, "rotation", 0, 5)
	intro_tween.tween_property(%LandratLogo, "position", Vector2(576,324), 5)
	intro_tween.chain().tween_property(%LandratLogo, "rotation", 5, 5).set_delay(5.0)
	intro_tween.parallel().tween_property(%LandratLogo, "position", Vector2(1372,324), 5).set_delay(5.0)
	intro_tween.chain().tween_property(%BlackOut, "rotation", .35, 3).set_trans(intro_tween.TRANS_ELASTIC).set_ease(intro_tween.EASE_OUT).set_delay(1.0)
	intro_tween.chain().tween_property(%BlackOut, "position", Vector2(0,1300), 1)
	
	#var update_volume = get_node("/root/Options")
	#option_vars.volume_change.connect(_update_volume)
	#print_debug(option_vars)
	
#func _update_volume(music_volume):
	#print_debug($AudioMain.volume_db, music_volume)
	#$AudioMain.volume_db = music_volume - 50

func _title_wiggle():
	title_tween.stop()
	title_tween = create_tween().set_loops()
	title_tween.tween_property(%GameTitle, "rotation", -.15, 10)
	title_tween.tween_property(%GameTitle, "rotation", .15, 10)
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_accept"):
		%BlackOut.visible = false
		%LandratLogo.visible = false

#Hide/show save slots with sound effects
func _on_button_new_game_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	#if %VBoxSlots.visible == true:
		#$AudioBack.play()
	#elif %VBoxSlots.visible == false:
		#$AudioConfirm.play()
	#%VBoxSlots.visible = !%VBoxSlots.visible

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

#Changes volume for music
func _on_slider_volume_value_changed(value):
	if value == 10:
		$AudioMain.volume_db = -100
	else:
		$AudioMain.volume_db = value - 50
	Options._on_value_changed(value)
