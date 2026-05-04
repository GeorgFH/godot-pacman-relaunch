extends CharacterBody3D

const SPEED = 3.0  

var direction = Vector3.ZERO

func _ready():
	randomize()
	
	var spawn_pos = Vector3(
		randf_range(-7, 7),
		1,
		randf_range(-7, 7)
	)
	
	var player = get_tree().current_scene.get_node("Player")
	
	# Abstand prüfen
	while spawn_pos.distance_to(player.global_position) < 3:
		spawn_pos = Vector3(
			randf_range(-7, 7),
			1,
			randf_range(-7, 7)
		)
	
	global_position = spawn_pos
	
	pick_new_direction()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0  
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()

func pick_new_direction():
	direction = Vector3(
		randf_range(-1, 1),
		0,
		randf_range(-1, 1)
	).normalized()
	
	change_direction_later()

func change_direction_later():
	await get_tree().create_timer(randf_range(1, 3)).timeout
	pick_new_direction()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Ui.check_game_end()
