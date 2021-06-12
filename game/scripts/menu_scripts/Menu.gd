extends Control

onready var settings:Settings = get_node("/root/Settings")
onready var project_name = ProjectSettings.get("application/config/name")

func _ready():
	# Ensure that the MainMenu is visible
	$MainMenu.visible = true
	
	# Ensure that the splash screens and other menus are not visible
	$ControlMenu.visible = false
	$QuitSplash.visible = false
	
	# Autofill project name
	$MainMenu/Title.text = project_name
	$QuitSplash/Credits.text = "%s made by:" % project_name
	
	# Give focus to the "Play!" button
	$MainMenu/Play.grab_focus()

# When the player presses the Quit Button
func _on_Quit_pressed():
	# Show the quit splash screen, This is mostly benifitial in an HTML5 Export
	$QuitSplash.visible = true
	
	# Wait for splash screen timeout defined in settings
	yield(get_tree().create_timer(settings.SECONDS_TO_SHOW_EXIT_SPLASH), "timeout")
	
	# Exit the game
	get_tree().quit()

# Open the link to the template repo on link click
func _on_TemplateShoutOut_meta_clicked(_meta):
	var _err = OS.shell_open("https://github.com/matt-cles/godot-game-template")

# When the player presses the controlls button
func _on_Controls_pressed():
	$ControlMenu.borrow_focus()
