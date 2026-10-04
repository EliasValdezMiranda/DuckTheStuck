# The functions and elements of the CharacterBody2D class are inherited into this script.
extends CharacterBody2D


# Two dictionaries are declared.
# The inside_area dictionary stores whether an object is currently inside an area or, using strings as keys to identify the current area.
var inside_area = {"Up": false, "Down": false, "Left": false, "Right": false}
# The rays dictionary stores the reference of each ray, using strings as keys to the direction of each ray.
@onready var rays = {"Up": $Up/RayUp, "Down": $Down/RayDown, "Left": $Left/RayLeft, "Right": $Right/RayRight}

# A variable to register whether the rock is moving or not is made.
var moving = false

# For each area, a signal is detected whenever it's entered or exited, updating the dictonary inside_area with the appropiate key.
func _on_up_area_entered(area):
	inside_area["Up"] = true
func _on_up_area_exited(area):
	inside_area["Up"] = false


func _on_down_area_entered(area):
	inside_area["Down"] = true
func _on_down_area_exited(area):
	inside_area["Down"] = false


func _on_left_area_entered(area):
	inside_area["Left"] = true
func _on_left_area_exited(area):
	inside_area["Left"] = false


func _on_right_area_entered(area):
	inside_area["Right"] = true
func _on_right_area_exited(area):
	inside_area["Right"] = false


func _unhandled_input(event):
	# Whenever an input is detected, a match statement detects whether an evaluation should be made or not.
	match GlobalInput.current_event:
		# Each case evaluates if the player is inside the area opposite to the pushed direction and if a ray is not colliding in the direction of the pushed object.
		# If the conditions are met, the "animate_rock" function is executed, passing the appropiate Vector as an argument.
		"Up":
			if inside_area["Down"] and !rays["Up"].is_colliding():
				animate_rock(Vector2.UP)
		"Down":
			if inside_area["Up"] and !rays["Down"].is_colliding():
				animate_rock(Vector2.DOWN)
		"Left":
			if inside_area["Right"] and !rays["Left"].is_colliding():
				animate_rock(Vector2.LEFT)
		"Right":
			if inside_area["Left"] and !rays["Right"].is_colliding():
				animate_rock(Vector2.RIGHT)
		_:
			pass

# The animate_rock function takes the vector of the direction the rock is to be moved as an argument.
func animate_rock(vector):
	# A sound is played.
	$AudioStreamPlayer.play()
	# A tween is created to handle the rock's position.
	var tween = create_tween()
	# The position is interpolated using the rock's position, the passed vector and tile size to move and the animation speed to use, as well as the transition.
	tween.tween_property(self, "position", position + vector * Game.TILE_SIZE, 1.0/Game.ANIMATION_SPEED).set_trans(Tween.TRANS_SINE)
	# The moving variable is set to true to prevent the rocked from being pushed during the animation.
	moving = true
	# The script waits for the tween animation to be done before setting the rock's moving variable back to false.
	await tween.finished
	moving = false
