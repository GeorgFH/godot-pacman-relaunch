extends MeshInstance3D
@export var speed = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var x = Input.get_axis("ui_left", "ui_right")
	var z = Input.get_axis("ui_up", "ui_down")
	var y = Input.get_axis("ui_page_down", "ui_page_up")

	position.x += x * delta * speed
	position.z += z * delta * speed
	position.y += y * delta * speed
