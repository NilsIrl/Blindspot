extends Node

func _ready():
	get_tree().call_group("navigation", "set_navigation", $World/Navigation)
	get_tree().call_group("player", "set_player", $World/Player)