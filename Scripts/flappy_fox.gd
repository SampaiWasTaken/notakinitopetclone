extends Node

@export var treeScene : PackedScene
@export var treeScene2 : PackedScene

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
var scenes

signal foxDead

func _ready():
	scenes = [treeScene, treeScene2]
	screen_size = get_window().size
	ground_height = 445
	new_game()

func new_game():
	game_running = false
	game_over = false
	get_tree().call_group("tree", "queue_free")
	trees.clear()
	generate_tree()
	$FlappyFox.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $FlappyFox.is_on_floor():
						$FlappyFox.jump()

func start_game():
	$"FlappyFox/AnimatedSprite2D".play("run")
	game_running = true
	$Timer.start()
	
func _process(delta):
	if game_running:
		$FlappyFox.position.x += 300 * delta
	
func generate_tree():
	var tree = scenes.pick_random().instantiate()
	tree.scale = Vector2(0.8, 0.8)
	tree.position.x = $FlappyFox.position.x + PIPE_DELAY
	tree.position.y = ground_height
	tree.hit.connect(fox_hit)
	add_child(tree)
	trees.append(tree)
	
func fox_hit():
	if not game_over:
		emit_signal("foxDead")
	game_running = false
	game_over = true
	$"FlappyFox/AnimatedSprite2D".play("rip")
	$DeathSound.play()
	
func _on_timer_timeout() -> void:
	$Timer.wait_time = randf_range(0.7, 1.7)
	generate_tree()
