extends Node2D
#UPDATE THE BUTTON TO LINK TO THE GDD!!!

func _process(_delta):
	#Starts playing the walk animation when first hovered over.
	if $GDDLinkButton.is_hovered() == true:
		$GDDMushyAnimatedSprite.play()
		#If the walk animation hits frame 12 and the mouse is still hovering over it will transition to dancing.
		if $GDDMushyAnimatedSprite.get_animation() == "walk" and $GDDMushyAnimatedSprite.get_frame() == 12 or $GDDMushyAnimatedSprite.get_animation() == "new_dance":
			$GDDMushyAnimatedSprite.set_animation("new_dance")
		elif $GDDLinkButton.is_hovered() == true:
			$GDDMushyAnimatedSprite.set_animation("walk")

#Each time an animation finishes it moves one step closer to getting to the default animation.
func _on_animation_finished():
	if $GDDMushyAnimatedSprite.get_animation() == "new_dance" and $GDDLinkButton.is_hovered() == true:
		return
	elif $GDDMushyAnimatedSprite.get_animation() == "new_dance" and $GDDLinkButton.is_hovered() == false:
		$GDDMushyAnimatedSprite.set_animation("walk")
		$GDDMushyAnimatedSprite.set_frame(12)
	elif $GDDMushyAnimatedSprite.get_animation() == "walk":
		$GDDMushyAnimatedSprite.set_animation("default")
		$GDDMushyAnimatedSprite.stop()
