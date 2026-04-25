extends Node3D

@export var obstacle_scenes: Array[PackedScene]
@export var spawn_count := 10

const COLLECTIBLE = preload("res://collectable/area_3d.tscn")

func _ready() -> void:
	randomize()

	if obstacle_scenes.is_empty():
		print("Keine Hindernis-Szenen zugewiesen!")
		return

	for i in spawn_count:
		var scene = obstacle_scenes.pick_random()

		if scene == null:
			print("Ein Eintrag in obstacle_scenes ist leer!")
			continue

		var obstacle = scene.instantiate()
		obstacle.position = Vector3(
		randf_range(-7.5, 7.5),
		1,
		randf_range(-7.5, 7.5)
		)
		add_child(obstacle)
	

func spawn_collectible():
	if get_tree().paused:
		return
	
	var c = COLLECTIBLE.instantiate()
	add_child(c)
	
	c.position = Vector3(
		randf_range(-7.5, 7.5),
		1.5,
		randf_range(-7.5, 7.5)
	)
	
	await get_tree().create_timer(1).timeout
	
	spawn_collectible()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
