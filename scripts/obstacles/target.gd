# The functions and elements of the Area2D class are inherited into this script.
extends Area2D


# When the target is stepped on, a sound plays and the global "stepping_on_diana" variable is set to true.
func _on_area_entered(area):
	$AudioStreamPlayer.play()
	Game.stepping_on_target = true


# When the target is stepped off from, the global "stepping_on_target" variable is set to false.
func _on_area_exited(area):
	Game.stepping_on_target = false
