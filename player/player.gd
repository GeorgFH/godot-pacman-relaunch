extends MeshInstance3D
const CUBE = preload("res://player2/player_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"): 
		print("SPAWN!")   # 👈 TEST
		var cube = CUBE.instantiate() as Node3D 
		add_child(cube)
		
		get_parent().add_child(cube)
		print("Parent:", get_parent())
		
		cube.position = Vector3(0, 2, 0) 
		print("New cube at:", cube.position)
