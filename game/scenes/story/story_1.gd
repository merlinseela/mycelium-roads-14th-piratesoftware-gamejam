extends Control

#All work and no sleep make Sislen a sleep cat :3

	#if story_progress == 0:
		#%Speaker.text = ""
		#%Words.text = ""
		#$Visual.set_frame()

var story_progress = 0

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept")==true:
		story_progress += 1
	
	if story_progress == 0:
		%Speaker.text = ""
		%Words.text = "Yelling. Garden. Night. Rain."
		$Visual.set_frame(4)
		
	if story_progress == 1:
		%Speaker.text = ""
		%Words.text = "Yelling. Garden. Night. Rain."
		$Visual.set_frame(3)	# wet walking noise/rain
		
	if story_progress == 2:
		%Speaker.text = ""
		%Words.text = "Yelling. Garden. Night. Rain."
		$Visual.set_frame(5)	# wet walking noise/rain
		
	if story_progress == 3:
		%Speaker.text = ""
		%Words.text = "!!!"
		$Visual.set_frame(6)	# wet walking noise/rain
		
	if story_progress == 4:
		%Speaker.text = ""
		%Words.text = "!!!"
		$Visual.set_frame(7)	
		
	if story_progress == 5:
		%Speaker.text = ""
		%Words.text = ""
		$Visual.set_frame(8)	
		
	if story_progress == 6:
		%Speaker.text = ""
		%Words.text = ""
		$Visual.set_frame(9)	
		
	if story_progress == 7:
		%Speaker.text = "???"
		%Words.text = "..."
		$Visual.set_frame(10)	
		
	if story_progress == 8:
		%Speaker.text = "???"
		%Words.text = "!!!"
		$Visual.set_frame(11)	
		
	if story_progress == 9:
		%Speaker.text = "SAM"
		%Words.text = "I-I’m sorry… I didn’t mean to wake you. "
		$Visual.set_frame(12)	
		
	if story_progress == 10:
		%Speaker.text = "SAM"
		%Words.text = "I-I’m sorry… I didn’t mean to wake you. "
		$Visual.set_frame(13)	
		
	if story_progress == 11:
		%Speaker.text = "SAM"
		%Words.text = "..."
		$Visual.set_frame(14)	
		
	if story_progress == 12:
		%Speaker.text = "SAM"
		%Words.text = "..."
		$Visual.set_frame(15)	
		
	if story_progress == 13:
		%Speaker.text = "SAM"
		%Words.text = "I need to get home… I don’t know where I am anymore and it’s so dark out here… It’s so cold… "
		$Visual.set_frame(16)	
		
	if story_progress == 14:
		%Speaker.text = "SAM"
		%Words.text = "!!!"
		$Visual.set_frame(17)	
		
	if story_progress == 15:
		%Speaker.text = "SAM"
		%Words.text = "!!!"
		$Visual.set_frame(0)	
		
	if story_progress == 16:
		%Speaker.text = "SAM"
		%Words.text = "!!!"
		$Visual.set_frame(2)	
		
	if story_progress == 17:
		%Speaker.text = ""
		%Words.text = "You wake. The sun has risen, the birds are chirping, and the garden is peaceful. "
		$Visual.visible != $Visual.visible
		
	if story_progress == 18:
		%Speaker.text = ""
		%Words.text = "Sam comes out of the farm and sees you wandering about."
		
	if story_progress == 19:
		%Speaker.text = "SAM"
		%Words.text = "Gyah! A walking mushroom? I thought these only existed in the books Ma keeps showing me… "
		$Visual.visible != $Visual.visible
		$Visual.set_frame(18)	
		
	if story_progress == 20:
		%Speaker.text = "SAM"
		%Words.text = "There’s no way… "
		$Visual.set_frame(18)	
		
	if story_progress == 21:
		%Speaker.text = "SAM"
		%Words.text = "Well, you are awfully cute, so there’s no way you’d be able to hurt me."
		$Visual.set_frame(18)	
		
	if story_progress == 22:
		%Speaker.text = "SAM"
		%Words.text = "You’re a mushroom after all… maybe I’ll call you Mushy!"
		$Visual.set_frame(18)	
		
	if story_progress == 23:
		%Speaker.text = "SAM"
		%Words.text = "You’re a mushroom after all… maybe I’ll call you Mushy!"
		$Visual.set_frame(18)	
		
	## There should be a few dialogue options here 
		
	if story_progress == 24:
		%Speaker.text = "???"
		%Words.text = "You’re a mushroom after all… maybe I’ll call you Mushy!"
		$Visual.set_frame(18)	
	#### INSERT DIALOGUE OPTIONS
	
	#MUSHROOM: Dialogue options:
#		… (anything but that)....
#		:D
#
#SAM: Dialogue answers
#Sorry…. ummmm…. well you do have a pretty round head… and so do I…. What about Roundhead? Or what about Stropharia caerulea?
#(No answer necessary here)
#
		#MUSHROOM: Dialogue options:
		#… well it’s better than “Mushy”…
		#something else?  (Text box)

		
	if story_progress == 31: # Change this
		%Speaker.text = "SAM"
		%Words.text = "Great! I’m so happy you’re here! You really helped me last night, and I want to keep you safe here so no hogs get you out there."
		$Visual.set_frame(18)	
		
	if story_progress == 32: # Change this
		%Speaker.text = ""
		%Words.text = "You jump around the garden excitedly, glad to be away from the forest predators. "
		$Visual.set_frame(18)	
		
	if story_progress == 33: # Change this
		%Speaker.text = "SAM"
		%Words.text = "Let’s get you set up… but I don’t know what you’d need… Can you show me what you need?"
		$Visual.set_frame(18)	
		
	if story_progress == 34: # Change this
		%Speaker.text = "SAM" # Change name depending on the dialogue options
		%Words.text = "Ah! I see! You need wood chips and water to grow! I wonder what else would help you… "
		$Visual.set_frame(18)	
		
	if story_progress == 35: # Change this
		%Speaker.text = "???" # Change name depending on the dialogue options
		%Words.text = "(Distant yell)"
		$Visual.set_frame(18)	
		
	if story_progress == 36: # Change this
		%Speaker.text = "SAM" # Change name depending on the dialogue options
		%Words.text = "I’ll be back later! See you soon!"
		$Visual.set_frame(18)	
	
