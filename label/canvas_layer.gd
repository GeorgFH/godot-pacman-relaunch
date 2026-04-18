extends CanvasLayer

@export var game_duration = 40
@export var win_score = 25

@onready var label: Label = $Label
@onready var reset_button: Button = $Button
@onready var start_button: Button = $Button_Start
@onready var timer_label: Label = $Label_Timer
@onready var result_label: Label = $Label_Result

var score = 0
var time_left = game_duration
var game_running = false

func _ready() -> void:
	get_tree().paused = true
	
	start_button.show()
	score = 0
	label.text = "Score: 0"
	timer_label.text = "Time: " + str(game_duration)
	result_label.text = ""  
		
	reset_button.pressed.connect(_on_reset)
	start_button.pressed.connect(_on_start)
	
func _on_start():
	get_tree().paused = false  
	start_button.hide()   
	result_label.text = ""
	
	get_tree().current_scene.spawn_collectible() 
	
	time_left = game_duration
	game_running = true
	start_timer()
	
func start_timer():
	while time_left > 0 and game_running:
		timer_label.text = "Time: " + str(time_left)
		await get_tree().create_timer(1).timeout
		time_left -= 1
	
	check_game_end()

func add_point():
	score += 1
	label.text = "Score: " + str(score)
	
	if score >= win_score and game_running: 
		check_game_end()
	
func check_game_end():
	game_running = false
	get_tree().paused = true
	
	if score >= win_score:
		result_label.text = "WIN!"
	else:
		result_label.text = "LOSE!"
	
func _on_reset():
	get_tree().paused = true

	score = 0
	label.text = "Score: 0"
	
	time_left = game_duration 
	timer_label.text = "Time: " + str(game_duration) 
	result_label.text = ""
	
	game_running = false
	
	start_button.show()
	
	for child in get_tree().current_scene.get_children():
		if child is Area3D:
			child.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
