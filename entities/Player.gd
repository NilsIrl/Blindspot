extends KinematicBody

const SPEED = 17
const GRAVITY = -9.8 * 20
const MOUSE_SENSITIVITY = -0.002
const JUMP_SPEED = 50

var was_on_wall = true

var enemy_left

var vel = Vector3()
var alive = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enemy_left = get_tree().get_nodes_in_group("zombie").size()

func _physics_process(delta):
	var dir = Vector3(0, 0, 0)
	var input_movement_vector = Vector2()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if Input.is_action_pressed("move_forward"):
			input_movement_vector.y -= 1
		if Input.is_action_pressed("move_backward"):
			input_movement_vector.y += 1
		if Input.is_action_pressed("move_left"):
			input_movement_vector.x -= 1
		if Input.is_action_pressed("move_right"):
			input_movement_vector.x += 1
	input_movement_vector = input_movement_vector.normalized() * SPEED
	dir += self.get_global_transform().basis.x.normalized() * input_movement_vector.x
	dir += self.get_global_transform().basis.y.normalized() * input_movement_vector.y
	dir.y = vel.y
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		dir.y += JUMP_SPEED

	dir.y += GRAVITY * delta

	vel = move_and_slide(dir, Vector3(0, 1, 0))
	
	for x in get_slide_count():
		var collision = get_slide_collision(x)
		var collider = collision.collider
		if "Floor" != collider.get_parent().get_name().left(5):
			if is_on_wall() and !was_on_wall:
				$BumpAudioStreamPlayer3D.global_transform.origin = collision.position
				$BumpAudioStreamPlayer3D.play()
	was_on_wall = is_on_wall()
	
	# SHOOT
	if Input.is_action_just_pressed("shoot") and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		$ShotAudioStreamPlayer.play()
		if $RayCast.is_colliding():
			var victim = $RayCast.get_collider()
			if victim.has_method("kill"):
				victim.kill()
				enemy_left -= 1
				$RayCast.add_exception(victim)
	
	# LEAVE/ENTER MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED or not alive else Input.MOUSE_MODE_CAPTURED)
	$GameplayGUI/EnemiesLeft.text = str(enemy_left) + " enemies left"

func updateUI(distance):
	$GameplayGUI/Label.text = "Distance remaining: " + str(int(distance)) + " m"

func kill(reason):
	if alive:
		$DieMenu/DieDialog.dialog_text = "You died from " + reason
		$DieMenu/DieDialog.popup()

func win():
	$WinMenu/WinDialog.popup()
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_y(event.relative.x * MOUSE_SENSITIVITY)
		$GameplayGUI/Cardinal.set_rotation($GameplayGUI/Cardinal.get_rotation() + event.relative.x * MOUSE_SENSITIVITY)

func _on_Dialog_about_to_show():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$GameplayGUI.visible = false
	alive = false

func _on_Dialog_popup_hide():
	get_tree().change_scene("res://menus/LevelSelector.tscn")
