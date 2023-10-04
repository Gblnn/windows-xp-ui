extends Control

var show_bar = false
var logged_out = false

func _ready():
	pass
	
func hide_start():
	$Taskbar/Start_menu.set_visible(false)
	$Taskbar/Start.set_pressed(false)
	
func logout():
	$Desktop.set_visible(false)
	$Taskbar.set_visible(false)
	$Login.set_visible(true)
	$Login/Profile.set_visible(true)
	$Login/ShutDown.set_visible(true)
	$Login/Fade.play("Fade")
	$Login/Login_Load_time.start()
	$Taskbar/Start_menu/Footer/Logout/Logout.play()
	logged_out = true
	pass
	
func login():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().quit()
		
	#Setting Time
	var time = Time.get_time_dict_from_system()
	var hour = int(time.hour)
	var minute = int(time.minute)
	var ap = ""
	
	#Setting Battery
	var battery = OS.get_power_percent_left()
	
	#Converting from 24hr to 12hr format
	if hour > 12:
		hour = hour - 12
		ap = "PM"
	else:
		ap = "AM"
		
	#Adding a zero before single digit minute value
	if minute < 10:
		minute = String("0" + String(minute))
		
	$Taskbar/Notification_bar/Time.text = String(hour) + ":" + String(minute) + " " + ap
	$Taskbar/Notification_bar/ProgressBar.value = battery


func _on_Startup_time_timeout():
	$BootSplash/Fade.play("New Anim")
	$BootSplash/Bar/Bar.play("Bar")
	$Boot_time.start()
	pass

func _on_Boot_time_timeout():
	$BootSplash/Fade.play_backwards("New Anim")
	$Login_time.start()
	pass

func _on_Login_time_timeout():
	$Login.set_visible(true)
	$Login/Fade.play("Fade")
	$Login/Login_Load_time.start()
	pass

func _on_Login_Load_time_timeout():
	$Login/Component_fade.play("New Anim")
	pass

func _on_Button2_pressed():
	$Login/Component_fade.play_backwards("New Anim")
	$Profile/Log_timer.start()
	$Desktop.set_visible(true)
	pass

func _on_Log_timer_timeout():
	if logged_out == false:
		$Login/Startup.play()
	else:
		$Taskbar/Start_menu/Footer/Logout/Login.play()
		
	$Login/Fade.play_backwards("Fade")
	$Taskbar/Taskbar_Timer.start()
	$Taskbar.set_visible(true)
	$Desktop/Icons.set_visible(true)
	$Login.set_visible(false)
	$Login/Profile.set_visible(false)
	pass

func _on_Taskbar_Timer_timeout():
	if logged_out == false:
		pass
	else:
		pass
	pass

func _on_Profile_name_pressed():
	$Login/Component_fade.play_backwards("New Anim")
	$Login/Profile/Log_timer.start()
	$Login/ShutDown.set_visible(false)
	$Desktop.set_visible(true)
	pass

func _on_ShutDown_pressed():
	$Login/ShutDown/Shutdown.play()
	$Login/Component_fade.play_backwards("New Anim")
	$Login/ShutDown/Shutting_down.play("New Anim")
	$Login/ShutDown/Shut_down_timer.start()
	pass

func _on_Shut_down_timer_timeout():
	get_tree().quit()
	pass

func _on_Start_toggled(button_pressed):
	if button_pressed == true:
		$Taskbar/Start_menu.set_visible(true)
	else:
		$Taskbar/Start_menu.set_visible(false)
		pass
	pass

func _on_Shutdown_pressed():
	hide_start()
	$Desktop.set_visible(false)
	$Taskbar.set_visible(false)
	$Login/Separator.set_visible(false)
	$Login/Begin.set_visible(false)
	$Login/Profile.set_visible(false)
	$Login/ShutDown.set_visible(false)
	$Login.set_visible(true)
	$Login/Fade.play("Fade")
	$Login/ShutDown/Shutdown.play()
	$Login/ShutDown/Shutting_down.play("New Anim")
	$Login/ShutDown/Shut_down_timer.start()
	pass

func _on_Logout_pressed():
	hide_start()
	logout()
	pass
	
func _on_Shutting_down_animation_finished(_anim_name):
	$Login/Profile.set_visible(false)
	$Login/ShutDown.set_visible(false)
	pass

func _on_Recycle_bin_pressed():
	$Desktop/Recycle_bin.set_visible(true)
	pass

func _on_Computer_pressed():
	$Desktop/My_Computer.set_visible(true)
	pass

func _on_Desktop_pressed():
	hide_start()
	$Label.text = "Desktop pressed"
	pass

func _on_LineEdit_text_entered(new_text):
	if new_text == "cmd":
		$Taskbar/Start_menu/Footer/LineEdit.text = ""
		$Desktop/Command_prompt.set_visible(true)
		hide_start()
	pass
