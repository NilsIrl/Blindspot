extends MeshInstance

const PlayerClass = preload("res://entities/Player.gd")

func _on_Area_body_entered(body):
	if body is PlayerClass:
		body.kill("falling into a pit.")
