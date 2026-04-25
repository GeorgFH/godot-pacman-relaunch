extends Area3D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	anim.play("new_animation1")

func _on_body_entered(body):
	# print("Kollision mit:", body.name)
	
	if body is CharacterBody3D:
		Ui.add_point()
		# print("Punkt!")
		audio.play()
		await audio.finished
		queue_free()   
