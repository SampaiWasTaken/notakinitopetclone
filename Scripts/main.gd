extends Node
@onready var _MainWindow: Window = get_window()
@onready var _SubWindow: Window = $Window
@onready var _SubWindow2: Window = $Window2
@onready var _SubWindow3: Window = $Window3

func _ready():
	#_SubWindow.world_2d = _MainWindow.world_2d
	_SubWindow2.world_2d = _MainWindow.world_2d
	_SubWindow3.world_2d = _MainWindow.world_2d


func _on_control_game_btn_pressed() -> void:
	var new_window = Window.new()
	new_window.title = "New Window"
	new_window.size = Vector2i(400, 300)  
	# Set window size
	new_window.position = Vector2i(100, 100)  
	# Set window position
	new_window.transparent_bg = false
	new_window.visible = true  
	# Show the window
	get_tree().root.add_child(new_window)
	pass # Replace with function body.
