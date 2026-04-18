extends Node3D

const COLLECTIBLE = preload("res://collectable/area_3d.tscn")

func _ready() -> void:
	randomize()
	

func spawn_collectible():
	if get_tree().paused:
		return
	
	var c = COLLECTIBLE.instantiate()
	add_child(c)
	
	c.position = Vector3(
		randf_range(-5, 5),
		randf_range(-3, 3),
		randf_range(-5, 5)
	)
	
	await get_tree().create_timer(1).timeout
	
	spawn_collectible()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
