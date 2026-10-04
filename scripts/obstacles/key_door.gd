# The functions and elements of the CharacterBody2D class are inherited into this script.
extends CharacterBody2D


# The closed variable registers whether the door is currently open or not.
var closed = true

func _process(delta):
	# If the character has a key and the door is closed, a sound effect plays, the door is moved out of sight and the closed variable is set to false.
	if Game.holding_key:
		if closed:
			$AudioStreamPlayer.play()
			self.position += Vector2.ONE * 1000000
			closed = false
	# If the character doesn't have a key and the door is open, a sound effect plays, the door is moved back into place and the closed variable is set to true.
	else:
		if !closed:
			$AudioStreamPlayer.play()
			self.position -= Vector2.ONE * 1000000
			closed = true
