extends CenterContainer

func _on_Button_pressed(level):
	get_tree().change_scene("res://levels/Level" + str(level) + ".tscn")
