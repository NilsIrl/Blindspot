extends Node

func _on_Button_pressed(menu):
	get_tree().change_scene("res://menus/" + menu + ".tscn")

func _on_FullscreenButton_pressed():
	OS.window_fullscreen = false if OS.window_fullscreen else true

func _on_QuitButton_pressed():
	get_tree().quit()
