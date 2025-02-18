extends Node
@onready var _MainWindow: Window = get_window()
@onready var _SubWindow: Window = $Node2D/Window
@onready var _SubWindow2: Window = $Window2
@onready var _SubWindow3: Window = $Window3

var gameRunning = false
signal gameOverText
var deathCount = 0
signal madFox
var foxmad = false

func _ready():
	#_SubWindow.world_2d = _MainWindow.world_2d
	_SubWindow2.world_2d = _MainWindow.world_2d
	_SubWindow3.world_2d = _MainWindow.world_2d

func _on_control_game_btn_pressed() -> void:
	if not gameRunning:
		
		#$Node2D/Window.always_on_top = false
		var new_window = Window.new()
		new_window.title = "New Window"
		new_window.size = Vector2i(640, 360)  
		# Set window size
		new_window.position = Vector2i(100, 100)  
		# Set window position
		new_window.transparent_bg = false
		new_window.visible = true  
		#new_window.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST = 0
		new_window.set("canvas_item_default_texture_filter", 0)
		new_window.set("unresizable", 1)
		new_window.set("initial_position",1)
		new_window.set("borderless",1)
		# Show the window
		var game = preload("res://Scenes/FlappyFox.tscn")
		var gameScene = game.instantiate()
		new_window.add_child(gameScene)
		
		gameScene.foxDead.connect(_on_fox_dead.bind(new_window))
		get_tree().root.add_child(new_window)
		
		
	
	pass # Replace with function body.
	
func _on_fox_dead(window: Window) -> void:
	#$Node2D/Window.always_on_top = true
	gameRunning = false
	deathCount += 1
	await get_tree().create_timer(2).timeout
	if deathCount >= 1 and not foxmad:
		emit_signal("madFox")
		foxmad = true
	window.queue_free()
	emit_signal("gameOverText")
	
	
	
