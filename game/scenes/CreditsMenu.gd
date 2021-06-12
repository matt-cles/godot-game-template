extends Submenu

func _on_Back_pressed():
	return_focus()

# Open the link to the template repo on link click
func _on_TemplateShoutOut_meta_clicked(_meta):
	var _err = OS.shell_open("https://github.com/matt-cles/godot-game-template")
