extends Node

@export var treeScene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 1
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200


func _ready():
	screen_size = get_window().size
	ground_height = 520
	new_game()

func new_game():
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	#$ScoreLabel.text = "SCORE: " + str(score)
	#$GameOver.hide()
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	#generate starting pipes
	generate_pipes()
	$FlappyFox.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $FlappyFox.flying:
						$FlappyFox.flap()
						check_top()

func start_game():
	game_running = true
	$FlappyFox.flying = true
	$FlappyFox.flap()
	#start pipe timer
	$PipeTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		$FlappyFox.position.x += SCROLL_SPEED
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED


func _on_pipe_timer_timeout():
	generate_pipes()
	
func generate_pipes():
	var pipe = treeScene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2  + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	#pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)
	
func scored():
	score += 1
	#$ScoreLabel.text = "SCORE: " + str(score)

func check_top():
	if $FlappyFox.position.y < 0:
		$FlappyFox.falling = true
		stop_game()

func stop_game():
	$PipeTimer.stop()
	#$GameOver.show()
	$FlappyFox.flying = false
	game_running = false
	game_over = true
	
func bird_hit():
	$FlappyFox.falling = true
	stop_game()

func _on_ground_hit():
	$FlappyFox.falling = false
	stop_game()

func _on_game_over_restart():
	new_game()


func _on_ground_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
