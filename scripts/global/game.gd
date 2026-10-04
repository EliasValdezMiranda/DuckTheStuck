# The global game script extends inherits the Node class.
extends Node


# Four constants are declared for their use in the rest of the scripts.
# The character identifier constant stores the name of the Character Node.
const CHARACTER_IDENTIFIER = "Character"
# The tile size constant stores the integer according to the size of a singular tile in pixels.
const TILE_SIZE = 16
# The animation speed stores an integer to use when declaring the speed in interpolated animations (tweens)
const ANIMATION_SPEED = 5
# The levels array stores the paths to each level in the game.
const LEVELS = ["res://scenes/levels/level0.tscn", "res://scenes/levels/level1.tscn", "res://scenes/levels/level2.tscn", "res://scenes/levels/level3.tscn", "res://scenes/levels/level4.tscn", "res://scenes/levels/level5.tscn", "res://scenes/levels/victory_screen.tscn"]

# Three variables are declared for their use in the rest of the scripts.
# The current level variable tracks the level currently loaded.
var current_level = 0
# The stepping on target variable tracks whether something is on top of a target or not.
var stepping_on_target = false
# The holding key variables tracks whether the character has grabbed a key or not.
var holding_key = false

# The reset scene function sets the global variables to their default state and reloads the current scene.
func reset_scene():
	stepping_on_target = false
	holding_key = false
	get_tree().reload_current_scene()
	return
