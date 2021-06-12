# This script is used by a singleton node called "Settings".
# The intended use for this script is to be used to store all user
# configurable settings, allowing all other nodes to use this Settings
# singleton as a source of truth.

extends Node

# Constants
# The path to the users config file
const CONFIG_FILE_PATH = "user://settings.cfg"

# How long to show the Quit Game splash screen
const SECONDS_TO_SHOW_EXIT_SPLASH = 5

# Variables

# Becomes a reference to the Config file
var config_file:ConfigFile

# The current version of the config file. This is to help with backwards
# compatibility, if there are ever breaking changes introduced to the
# config file
var config_file_version:SymanticVersion

# The config version to update the config file to, or create the new file at.
# On any change to this file, you should update this Symantic Version
var new_config_file_version = SymanticVersion.new(1, 0, 0)

# Basic volume settings
var music_volume = 0
var sfx_volume = 0

# Basic input settings
var move_left = "ui_left"
var move_right = "ui_right"
var move_up = "ui_up"
var move_down = "ui_down"
var action = "ui_accept"
var pause = "ui_cancel"

# Input defaults map
var input_defaults = {
	move_left: 'left',
	move_right: 'right',
	move_up: 'up',
	move_down: 'down',
	action: 'space',
	pause: 'escape',
}

# In this function, you can fix/reformat old config files to prevent breaking
# config changes from corrupting user data
func check_for_config_incompatibility():
	## EX: The difficulty value that was stored changed after version 0.5.0 
	# if config_file_version.less_than(SymanticVersion.new(0.5)):
		# difficulty = difficulty * 10 + 1

	## EX: There was a key typo before version 1.0.1
	# if config_file_version.less_than(SymanticVersion.new(1, 0, 1)):
		# var temp = config_file.get_value("meta", "versoin", new_config_file_version)
		# config_file.erase_section_key("meta", "versoin")
		# config_file.set_value("meta", "version", temp)

	## Pass can safely be removed once there exists a config incompatibility above.
	pass

func _ready():
	config_file = ConfigFile.new()
	var _err = config_file.load(CONFIG_FILE_PATH)
	config_file_version = config_file.get_value("meta", "version", new_config_file_version)
	
	# Check config file for incompatibility of previous versions
	check_for_config_incompatibility()

	# Set up controls
	set_up_controls()

func set_up_controls():
	# Initialize the input events to ensure they have no extra inputs
	#var inputs = [move_left, move_right, move_up, move_down, action, pause]
	for input in input_defaults:
		if InputMap.has_action(input):
			InputMap.action_erase_events(input)
		else:
			InputMap.add_action(input)
		var default_key = InputEventKey.new()
		default_key.scancode = OS.find_scancode_from_string(input_defaults[input])
		var config_key = config_file.get_value("input", input, default_key)
		InputMap.action_add_event(input, config_key)

func remap_key(input_event, event):
	config_file.set_value("input", input_event, event)
	var _err = config_file.save(CONFIG_FILE_PATH)
	InputMap.action_erase_events(input_event)
	InputMap.action_add_event(input_event, event)
