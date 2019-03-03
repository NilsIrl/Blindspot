extends Area

const ROTATION_SPEED = 3

var navigation
var player

func _physics_process(delta):
	rotate(delta)
	if navigation and player:
		var path = navigation.get_simple_path(player.get_translation(), self.get_translation(), true)
		if path[1] != $AudioStreamPlayer3D.get_translation():
			print(path[1])
			print($AudioStreamPlayer3D.get_translation())
			$AudioStreamPlayer3D.set_translation(path[1])

func rotate(delta):
	rotate_x(ROTATION_SPEED * delta)
	rotate_y(ROTATION_SPEED * delta)
	rotate_z(ROTATION_SPEED * delta)

func set_player(player):
	self.player = player

func set_navigation(navigation):
	self.navigation = navigation
