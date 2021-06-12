# This script is used by a singleton node called "Settings".
# The intended use for this script is to be used to store all user
# configurable settings, allowing all other nodes to use this Settings
# singleton as a source of truth.

extends Node

# Constants
# The path to the users config file
const CONFIG_FILE_PATH = "user://settings.cfg"

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
var ui_accept = "ui_accept"
var cancel = "ui_cancel"
var action = "action"

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

	pass

func _ready():
	config_file = ConfigFile.new()
	var _err = config_file.load(CONFIG_FILE_PATH)
	config_file_version = config_file.get_value("meta", "version", new_config_file_version)
	check_for_config_incompatibility()
