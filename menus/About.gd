extends Node

func _on_Button_pressed():
	get_tree().change_scene("res://menus/MainMenu.tscn")

func _on_FullscreenButton_pressed():
	OS.window_fullscreen = false if OS.window_fullscreen else true
