extends MeshInstance3D

const CUBE = preload("res://cube.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("SPAWN!")
		
		var cube = CUBE.instantiate()
		get_parent().add_child(cube)
		
		cube.position = self.position + Vector3(
			randf_range(-3, 3),
			2,
			randf_range(-3, 3)
			)
