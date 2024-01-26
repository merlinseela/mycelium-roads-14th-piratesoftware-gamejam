extends Control

#All work and no sleep make Sislen a sleep cat :3

var story_progress = 0
var mushroom_name = "Mushy"
@onready var option_vars = get_node("/root/Options")

func _ready(): 
	$OpeningSceneAudio.get_child(0).play()
	$OpeningSceneAudio.get_child(0).volume_db = option_vars.music_volume - 50

func _kill_audio(): 
	var num_tracks = $OpeningSceneAudio.get_child_count()
	for i in range(0, num_tracks): 
		$OpeningSceneAudio.get_child(i).stop()

func _change_music(track_num): 
	_kill_audio()
	$OpeningSceneAudio.get_child(track_num).play()
	$OpeningSceneAudio.get_child(track_num).volume_db = option_vars.music_volume - 50
	pass

func _process(_delta):
	
	if Input.is_action_just_pressed("ui_accept")==true and $Buttons.visible == false:
		story_progress += 1
		if story_progress == 3:
			_change_music(1)
		if story_progress == 7: 
			_change_music(2)
		if story_progress == 17:
			_change_music(3)
		print_debug(story_progress)

	match story_progress: 
		0: 
			%Speaker.text = ""
			%Words.text = "Yelling. Garden. Night. Rain."
			$Visual.set_frame(4)
		1: 
			%Speaker.text = ""
			%Words.text = "Yelling. Garden. Night. Rain."
			$Visual.set_frame(3)	# wet walking noise/rain
		2: 
			%Speaker.text = ""
			%Words.text = "Yelling. Garden. Night. Rain."
			$Visual.set_frame(5)	# wet walking noise/rain
		3: 
			%Speaker.text = ""
			%Words.text = "!!!"
			$Visual.set_frame(6)	# wet walking noise/rain
		4: 
			%Speaker.text = ""
			%Words.text = "!!!"
			$Visual.set_frame(7)
		5: 
			%Speaker.text = ""
			%Words.text = ""
			$Visual.set_frame(8)
		6: 
			%Speaker.text = ""
			%Words.text = ""
			$Visual.set_frame(9)
		7:
			%Speaker.text = "???"
			%Words.text = "..."
			$Visual.set_frame(10)
		8:
			%Speaker.text = "???"
			%Words.text = "!!!"
			$Visual.set_frame(11)
		9:
			%Speaker.text = "SAM"
			%Words.text = "I-I’m sorry… I didn’t mean to wake you. "
			$Visual.set_frame(12)
		10:
			%Speaker.text = "SAM"
			%Words.text = "I-I’m sorry… I didn’t mean to wake you. "
			$Visual.set_frame(13)
		11: 
			%Speaker.text = "SAM"
			%Words.text = "..."
			$Visual.set_frame(14)
		12: 
			%Speaker.text = "SAM"
			%Words.text = "..."
			$Visual.set_frame(15)
		13: 
			%Speaker.text = "SAM"
			%Words.text = "I need to get home… I don’t know where I am anymore and it’s so dark out here… It’s so cold… "
			$Visual.set_frame(16)
		14: 
			%Speaker.text = "SAM"
			%Words.text = "!!!"
			$Visual.set_frame(17)
		15: 
			%Speaker.text = "SAM"
			%Words.text = "!!!"
			$Visual.set_frame(0)
		16: 
			%Speaker.text = "SAM"
			%Words.text = "!!!"
			$Visual.set_frame(2)
		17: 
			%Speaker.text = ""
			%Words.text = "You wake. The sun has risen, the birds are chirping, and the garden is peaceful. "
			$Visual.visible = false
		18: 
			%Speaker.text = ""
			%Words.text = "Sam comes out of the farm and sees you wandering about."
		19: 
			%Speaker.text = "SAM"
			%Words.text = "Gyah! A walking mushroom? I thought these only existed in the books Ma keeps showing me… "
			$Visual.visible = true
			$Visual.set_frame(18)
		20: 
			%Speaker.text = "SAM"
			%Words.text = "There’s no way… "
			$Visual.set_frame(18)
		21: 
			%Speaker.text = "SAM"
			%Words.text = "Well, you are awfully cute, so there’s no way you’d be able to hurt me."
			$Visual.set_frame(18)
		22:
			%Speaker.text = "SAM"
			%Words.text = "You’re a mushroom after all… maybe I’ll call you Mushy!"
			$Visual.set_frame(18)
		23: 
			%Speaker.text = "???"
			%Words.text = ""
			$Visual.set_frame(18)
			$Buttons.visible = true
			%LabelChoice1.text = "...(anything but that)..."
			%LabelChoice2.text = ":D"
		24: 
			%Speaker.text = "SAM"
			$Buttons.visible = false
			%Words.text = "Sorry…. ummmm…. well you do have a pretty round head… and so do I…. \n What about Roundhead? Or what about Stropharia caerulea?"
			$Visual.set_frame(18)
		25: 
			%Speaker.text = "???"
			%Words.text = ""
			$Buttons.visible = true
			%LabelChoice1.text = "… well it’s better than 'Mushy'…"
			%LabelChoice2.text = "Roundhead?"
			$Visual.set_frame(18)
		31: 
			%Speaker.text = "SAM"
			%Words.text = "Great! I’m so happy you’re here! You really helped me last night, \n and I want to keep you safe here so no hogs get you out there."
			$Visual.set_frame(18)
			$Buttons.visible = false
		32: 
			%Speaker.text = ""
			%Words.text = "You jump around the garden excitedly, glad to be away from the forest predators. "
			$Visual.set_frame(18)
		33: 
			%Speaker.text = "SAM"
			%Words.text = "Let’s get you set up… but I don’t know what you’d need… Can you show me what you need?"
			$Visual.set_frame(18)
		34: 
			%Speaker.text = "SAM" # Change name depending on the dialogue options
			%Words.text = "Ah! I see! You need wood chips and water to grow! I wonder what else would help you… "
			$Visual.set_frame(18)

		35: 
			%Speaker.text = "???" # Change name depending on the dialogue options
			%Words.text = "(Distant yell)"
			$Visual.set_frame(18)
			
		36: 
			%Speaker.text = "SAM" # Change name depending on the dialogue options
			%Words.text = "I’ll be back later! See you soon!"
			$Visual.set_frame(18)
		37: 
			get_tree().change_scene_to_file("res://main.tscn")
			

func _on_button_choice_1_pressed():
	if story_progress == 23:
		story_progress = 24
	if story_progress == 25:
		story_progress = 31
		mushroom_name = "Roundhead"
		$Buttons.visible = false

func _on_button_choice_2_pressed():
	if story_progress == 23:
		story_progress = 31
	if story_progress == 25: 
		story_progress = 31
		mushroom_name = "Mushy"
		$Buttons.visible = false
