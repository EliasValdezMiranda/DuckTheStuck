# The functions and elements of the Node2D class are inherited into this script.
extends Node2D


# After a two second timer, the title screen scene is changed to the first level of the game.
func _on_timer_timeout():
	get_tree().change_scene_to_file(Game.LEVELS[Game.current_level])
