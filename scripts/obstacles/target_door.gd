# The functions and elements of the CharacterBody2D class are inherited into this script.
extends CharacterBody2D


# The closed variable registers whether the door is currently open or not.
var closed = true

func _process(delta):
	# If there's a target being stepped on and the door is closed, a sound effect plays, the door is moved out of sight and the closed variable is set to false.
	if Game.stepping_on_target:
		if closed:
			$AudioStreamPlayer.play()
			self.position += Vector2.ONE * 1000000
			closed = false
	# If the target is not being stepped on and the door is open, a sound effect plays, the door is moved back into place and the closed variable is set to true.
	else:
		if !closed:
			$AudioStreamPlayer.play()
			self.position -= Vector2.ONE * 1000000
			closed = true
