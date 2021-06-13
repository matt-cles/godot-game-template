# thanks to the godot-demo for input mapping available here:
# https://github.com/godotengine/godot-demo-projects/tree/master/gui/input_mapping

class_name RemappableButton
extends Button

onready var settings:Settings = get_node("/root/Settings")
onready var events:Events = get_node("/root/Events")

export var input_event = "enter_input_event_here"

var raw_text
var any_key_remapping = false
var remapping_this_key = false

func _ready():
	# Capture the button label
	raw_text = text
	# Don't process unhandled_key_input events yet
	set_process_unhandled_key_input(false)
	# Update the text to show the current key assigned
	show_current_key()
	# Set up event to prevent remapping multiple keys at once
	var _err = events.connect("remapping_key", self, "pause_mapping")

func show_current_key():
	var current_keys = InputMap.get_action_list(input_event)
	var current_key_text = "None"
	if current_keys:
		current_key_text = current_keys[0].as_text()
	text = "%s [%s]" % [raw_text, current_key_text]
	
func _toggled(button_pressed):
	if not any_key_remapping or remapping_this_key:
		release_focus()
		yield(get_tree().create_timer(0.01), "timeout")
		set_process_unhandled_key_input(button_pressed)
		remapping_this_key = button_pressed
		events.emit_signal("remapping_key", button_pressed)
		if button_pressed:
			text = "%s [...]" % raw_text
		else:
			show_current_key()
			grab_focus()
	else:
		pressed = false

func _unhandled_key_input(event):
	remap_event(event)
	pressed = false
	grab_focus()

func remap_event(event):
	settings.remap_key(input_event, event)
	show_current_key()

func pause_mapping(val):
	any_key_remapping = val
	disabled = any_key_remapping and not remapping_this_key
	focus_mode = (Control.FOCUS_ALL) * int(not disabled)
