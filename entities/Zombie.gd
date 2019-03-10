extends KinematicBody

const SPEED = 20
const GRAVITY = -9.8 * 10
var navigation
var player
var alive = true

func _physics_process(delta):
	if navigation and player:
		var path = navigation.get_simple_path(self.get_translation(), player.get_translation(), true)
		var move_vec = path[1] - self.get_translation()
		move_vec.y = 0
		move_vec = move_vec.normalized() * SPEED
		move_vec.y += GRAVITY * delta
		move_and_slide(move_vec, Vector3(0, 1, 0))
		
		for x in get_slide_count():
			if get_slide_collision(x).collider == player:
				player.kill("hugging a zombie.")

func set_navigation(navigation):
	self.navigation = navigation

func set_player(player):
	self.player = player

func kill():
	if alive:
		queue_free()
		self.alive = false
