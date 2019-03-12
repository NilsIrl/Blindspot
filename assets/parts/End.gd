extends Spatial

const ROTATION_SPEED = 3
const INITIAL_DB = 0

var navigation
var player

func _physics_process(delta):
	rotate_own(delta)
	if navigation and player:
		var path = remove_intermediate_points(navigation.get_simple_path(player.get_translation(), self.get_translation(), true))
		if path.size() >= 2:
			if path[1] != $AudioStreamPlayer3D.global_transform.origin:
				$AudioStreamPlayer3D.set_translation(path[1] - self.get_global_transform().origin)
			var distance_to_end = path_distance(path)
			$AudioStreamPlayer3D.unit_db = INITIAL_DB + linear2db(1 / (distance_to_end / $AudioStreamPlayer3D.unit_size))
			$AudioStreamPlayer3D.set_rotation(Vector3(0, player.get_rotation().y, 0))
			$AudioStreamPlayer3D.transform.basis = $AudioStreamPlayer3D.transform.basis.rotated(Vector3(0, 1, 0), deg2rad(180))
			player.updateUI(distance_to_end)

func rotate_own(delta):
	$EndPoint.rotate_x(ROTATION_SPEED * delta)
	$EndPoint.rotate_y(ROTATION_SPEED * delta)
	$EndPoint.rotate_z(ROTATION_SPEED * delta)

func set_player(player):
	self.player = player

func set_navigation(navigation):
	self.navigation = navigation

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

func path_distance(path):
	var distance = 0
	for x in path.size() - 1:
		distance += path[x].distance_to(path[x + 1])
	return distance

func _on_EndPoint_body_entered(body):
	if body.has_method("win"):
		body.win()
