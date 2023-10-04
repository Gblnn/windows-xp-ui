extends Panel

func _on_Close_pressed():
	set_visible(false)
	pass

func _on_Command_prompt_visibility_changed():
	$Body/LineEdit.grab_focus()
	pass
