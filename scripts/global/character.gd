# The functions and elements of the Area2D class are inherited into this script.
extends Area2D


# References to other nodes are declared and stored into variables. when the node is ready.
# A node for the ray cast from the player's position towards the direction it's facing is stored.
@onready var ray = $RayCast2D
# A node for the animation player is stored.
@onready var animation_player = $AnimationPlayer

# A variable to register whether the player is moving or not is made.
var moving = false
# A dictionary to detect the received inputs and the vectors to return is made.
# The keys take the name of the action events registered in the Input Map as a string.
# The values store the direction each 2-dimensional vector has according to the input given.
var inputs = {"Right": Vector2.RIGHT,
			"Left": Vector2.LEFT,
			"Up": Vector2.UP,
			"Down": Vector2.DOWN}

func _ready():
	# A small jingle is played.
	$Ready_Jingle.play()
	# The character's position is rounded to the size of our tiles, adding an additional half tile to center the position.
	position = position.snapped(Vector2.ONE * Game.TILE_SIZE)
	position += Vector2.ONE * Game.TILE_SIZE/2

func _unhandled_input(event):
	# If there's an input and the character is not moving, the move function is called.
	if !moving:
		move(GlobalInput.current_event)

# The function move handles character movement, taking the direction the character is currently facing as an argument.
func move(dir):
	# The movement function is only executed if there's a non-null direction.
	if dir:
		# The character ray's direction is appropiately adjusted according to the direction's vector and the tile size.
		ray.target_position = inputs[dir] * Game.TILE_SIZE
		# The ray is forced to be updated to ensure detecting the correct collision before any other change is made.
		ray.force_raycast_update()
		# If no object is detected in front of the character, the movement is handled.
		if !ray.is_colliding():
			# A tween is created to handle the character's position.
			var tween = create_tween()
			# The position is interpolated using the character's position, the direction and tile size to move and the animation speed to use, as well as the transition.
			tween.tween_property(self, "position", position + inputs[dir] * Game.TILE_SIZE, 1.0/Game.ANIMATION_SPEED).set_trans(Tween.TRANS_SINE)
			# The moving variable is set to true to prevent movement during the current movement animation.
			moving = true
			# The appropiate animation for the movement and the faced direction is played, along with a sound effect.
			$Movement.play()
			animation_movement(dir)
			# When the tween finishes the interpolation, the animation is reset to an idle state and the moving variable is set to false.
			await tween.finished
			animation_idle(dir)
			moving = false
		# If there's an object in front of the character, a sound effect is played and the animation is reset.
		else:
			$Bonk.play()
			animation_idle(dir)

# A match function is used to play the appropiate movement animation for the direction the character is facing.
func animation_movement(dir):
	match dir:
			"Up":
				animation_player.play("movement_up")
			"Down":
				animation_player.play("movement_down")
			"Left":
				animation_player.play("movement_left")
			"Right":
				animation_player.play("movement_right")

# A match function is used to play the appropiate idle animation for the direction the character is facing.
func animation_idle(dir):
	match dir:
			"Up":
				animation_player.play("idle_up")
			"Down":
				animation_player.play("idle_down")
			"Left":
				animation_player.play("idle_left")
			"Right":
				animation_player.play("idle_right")
