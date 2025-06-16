extends CharacterBody3D

const SPEED = 3.5
const JUMP_VELOCITY = 3

@export var cam : Camera3D
@export var head : Node3D

var mouse_input
var cam_sens = 0.25

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Engine.max_fps = 29.97
	%Date.text = Time.get_date_string_from_system()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: #If mouse is moving
		mouse_input = event.relative
		head.rotate_y(-event.relative.x * cam_sens * get_process_delta_time()) #Look left and right
		cam.rotate_x(-event.relative.y * cam_sens * get_process_delta_time()) #Look up and down
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-70), deg_to_rad(50)) #Stop turning so player's neck doesn't break
	if Input.is_action_just_pressed("exit"): #When backspace is pressed
		get_tree().quit() #quits game
	if Input.is_action_just_pressed("action"):
		if %RayCast3D.is_colliding():
			if %RayCast3D.get_collider().is_in_group("cam"):
				%RayCast3D.get_collider().change_cam()

func _process(delta: float) -> void:
	%Time.text = Time.get_time_string_from_system()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	 #Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBackward")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
