# The functions and elements of the Area2D class are inherited into this script.
extends Area2D


func _on_area_entered(area):
	# The identifier variable stores the object which entered the area converted to a string.
	var identifier = area.to_string()
	# If the identifier begins with the character identifier constant, a sound effect is played, the object's position is displaced out of camera and the global variable "holding_key" is set to true.
	if identifier.begins_with(Game.CHARACTER_IDENTIFIER):
		$AudioStreamPlayer.play()
		Game.holding_key = true
		self.position += Vector2.ONE * 1000000
