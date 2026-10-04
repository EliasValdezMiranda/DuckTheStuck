# The functions and elements of the Area2D class are inherited into this script.
extends Area2D


func _on_area_entered(area):
	# The identifier variable stores the object which entered the area converted to a string.
	var identifier = area.to_string()
	# If the identifier begins with the character identifier constant, the object's position is displaced out of camera and a timer is started.
	if identifier.begins_with(Game.CHARACTER_IDENTIFIER):
		self.position += Vector2.ONE * 10000000
		$Timer.start()

func _on_timer_timeout():
	# When the timer ends, the game's global variables are reset and the level is changed.
	Game.stepping_on_target = false
	Game.holding_key = false
	Game.current_level += 1
	get_tree().change_scene_to_file(Game.LEVELS[Game.current_level])
