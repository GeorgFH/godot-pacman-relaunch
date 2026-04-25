extends CanvasLayer

@export var game_duration = 60
@export var win_score = 5
@export var stage = 0

@onready var stage_label: Label = $Stage
@onready var label: Label = $Score
@onready var reset_button: Button = $Reset
@onready var start_button: Button = $Start
@onready var timer_label: Label = $Timer
@onready var result_label: Label = $Result
@onready var game_over_sound: AudioStreamPlayer = $GameOverSound
@onready var game_win_sound: AudioStreamPlayer = $GameWinSound

var score = 0
var time_left = game_duration
var game_running = false
var base_win_score = 0

func _ready() -> void:
	get_tree().paused = true
	
	base_win_score = win_score
	
	start_button.show()
	score = 0
	label.text = "Score: 0 / " + str(win_score)
	
	timer_label.text = "Time: " + str(game_duration)
	stage_label.text = "Stage: " + str(stage)  
		
	reset_button.pressed.connect(_on_reset)
	start_button.pressed.connect(_on_start)
	
func _on_start():
	
	get_tree().current_scene.build_map(stage)
	get_tree().current_scene.spawn_enemies(stage)
	
	stage += 1 
	stage_label.text = "Stage: " + str(stage)
	score = 0
	
	win_score = base_win_score + int(stage * (stage - 1) / 2)
	
	label.text = "Score: 0 / " + str(win_score)
	
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
	label.text = "Score: " + str(score) +" / " + str(win_score)
	
	if score >= win_score and game_running: 
		check_game_end()
	
func check_game_end():
	game_running = false
	
	get_tree().paused = true
	
	if score >= win_score:
		result_label.text = "WIN! Stage: " + str(stage)
		start_button.show()
		game_win_sound.play()
		
	else:
		result_label.text = "LOSE! Stage: " + str(stage)
		game_over_sound.play()
	
func _on_reset():
	get_tree().paused = true
	
	score = 0
	stage = 0
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
