extends Node

func _on_Button_pressed(menu):
	get_tree().change_scene("res://menus/" + menu + ".tscn")
