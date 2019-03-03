extends KinematicBody

const SPEED = 5

var navigation
var player
var alive = true

func _physics_process(delta):
	if navigation and player:
		var path = navigation.get_simple_path(self.get_translation(), player.get_translation(), true)
		var move_vec = path[1] - self.global_transform.origin
		move_vec = move_vec.normalized() * SPEED
		move_and_slide(move_vec, Vector3(0, 1, 0))
		if len(path) == 2:
			$AudioStreamPlayer3D.play()
		else:
			$AudioStreamPlayer3D.stop()


func set_navigation(navigation):
	self.navigation = navigation

func set_player(player):
	self.player = player

func kill():
	if alive:
		queue_free()
		self.alive = false
