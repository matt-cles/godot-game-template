extends Control
class_name Submenu

var focus_return = null
export (NodePath) var default_focus = null

func borrow_focus():
	visible = true
	focus_return = get_focus_owner()
	if default_focus:
		get_node(default_focus).grab_focus()

func return_focus():
	if focus_return:
		visible = false
		focus_return.grab_focus()
		focus_return = null
