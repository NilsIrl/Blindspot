extends KinematicBody

const SPEED = 20
const GRAVITY = -9.8 * 10
const NUMBER_OF_TURNS_TO_HEAR = 4

var navigation
var player
var alive = true

func _physics_process(delta):
	if navigation and player and alive:
		var path = remove_intermediate_points(navigation.get_simple_path(self.get_translation(), player.get_translation(), true))
		var move_vec = path[1] - self.get_translation()
		move_vec.y = 0
		move_vec = move_vec.normalized() * SPEED
		move_vec.y += GRAVITY * delta
		move_and_slide(move_vec, Vector3(0, 1, 0))
		if path.size() <= NUMBER_OF_TURNS_TO_HEAR and !$AudioStreamPlayer3D.is_playing() and alive:
			$AudioStreamPlayer3D.play()
		elif path.size() > NUMBER_OF_TURNS_TO_HEAR:
			$AudioStreamPlayer3D.stop()

		for x in get_slide_count():
			if get_slide_collision(x).collider == player:
				player.kill("hugging a zombie.")

func set_navigation(navigation):
	self.navigation = navigation

func set_player(player):
	self.player = player

func kill():
	if alive:
		self.alive = false
		$AudioStreamPlayer3D.stop()
		$DeathAudioStreamPlayer3D.play()

func _on_DeathAudioStreamPlayer3D_finished():
	queue_free()

func remove_intermediate_points(simple_path):
	var x = 1
	while x < len(simple_path) - 1:
		if is_intermediate_point(simple_path[x-1], simple_path[x], simple_path[x+1]):
			simple_path.remove(x)
		else:
			x+=1
	return simple_path

func is_intermediate_point(a, b, c):
	return abs((c.z - a.z) * b.x - (c.x - a.x) * b.z + c.x * a.z - c.z * a.x)/sqrt(pow((c.z - a.z), 2) + pow((c.x - a.x), 2)) < 0.01