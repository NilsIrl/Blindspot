extends Area

const PlayerClass = preload("res://entities/Player.gd")

func _on_Void_body_entered(body):
	if body is PlayerClass:
		body.kill("falling into the void.")
