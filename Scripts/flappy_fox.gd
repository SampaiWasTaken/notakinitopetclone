extends Node

@export var treeScene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 1
var screen_size : Vector2i
var ground_height : int
var trees : Array
const PIPE_DELAY : int = 600
const PIPE_RANGE : int = 200


func _ready():
	screen_size = get_window().size
	ground_height = 300
	new_game()

func new_game():
	#reset variables
	game_running = false
	game_over = false
	#score = 0
	#scroll = 0
	#$ScoreLabel.text = "SCORE: " + str(score)
	#$GameOver.hide()
	get_tree().call_group("tree", "queue_free")
	trees.clear()
	#generate starting pipes
	generate_tree()
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

func start_game():
	game_running = true
	$FlappyFox.flying = true
	$FlappyFox.flap()
	#start pipe timer
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		$FlappyFox.position.x += 5
	
func generate_tree():
	print("tree")
	var tree = treeScene.instantiate()
	tree.position.x = $FlappyFox.position.x + PIPE_DELAY
	tree.position.y = ground_height
	tree.hit.connect(fox_hit)
	add_child(tree)
	trees.append(tree)
	
func fox_hit():
	print("hit")


func _on_timer_timeout() -> void:
	generate_tree()
