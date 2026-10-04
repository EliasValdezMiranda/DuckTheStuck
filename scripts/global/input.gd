# The global input script extends inherits the Node class.
extends Node


# An array containing the action events in the input map is declared.
const EVENTS = ["Up", "Down", "Left", "Right", "Restart"]

# A variable detailing the current event according to the input is declared to null as default.
var current_event = null

func _unhandled_input(event):
	# When an input is detected, a loop is called for each event in the events constant
	for input in EVENTS:
		# If the event is a restart, the reset scene is called from the global game script.
		if event.is_action_pressed("Restart"):
			Game.reset_scene()
			return
		# If the event is not a restart and matches one in the events constant, the current event variable is set to that input.
		elif event.is_action_pressed(input):
			current_event = input
			return
	# If the pressed key does not match any other keys, the current event variable is set to null.
	current_event = null
