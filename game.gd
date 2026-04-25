extends Node3D

const COLLECTIBLE = preload("res://collectable/area_3d.tscn")
const ENEMY = preload("res://enemy.tscn")

@export var enemy_count = 3

func _ready() -> void:
	randomize()
	spawn_enemies()
	

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

func spawn_enemies():
	for i in range(enemy_count):
		var e = ENEMY.instantiate()
		add_child(e)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
