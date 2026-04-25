extends CharacterBody3D

@export var SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SPRINT_MULTIPLIER = 2

@onready var model = $Sketchfab_Scene 

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("boost"):
		SPEED+=SPRINT_MULTIPLIER;
	if Input.is_action_just_released("boost"):
		SPEED-=SPRINT_MULTIPLIER;
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# 👉 HIER drehen wir den Player
	if direction != Vector3.ZERO:
		model.look_at(global_position - direction, Vector3.UP)

	move_and_slide()
