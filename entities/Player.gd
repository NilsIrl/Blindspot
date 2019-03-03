extends KinematicBody

const SPEED = 4
const GRAVITY = -9.8
const MOUSE_SENSITIVITY = -0.002

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var dir = Vector3()
	var input_movement_vector = Vector2()
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
	dir.y = GRAVITY
	move_and_slide(dir)
	
	
	# SHOOT
	if Input.is_action_just_pressed("shoot") and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and $RayCast.is_colliding():
		var victim = $RayCast.get_collider()
		if victim.has_method("kill"):
			victim.kill()
	
	# LEAVE/ENTER MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_y(event.relative.x * MOUSE_SENSITIVITY)