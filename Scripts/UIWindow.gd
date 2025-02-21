extends Window

@onready var _Camera: Camera2D = $"../Node2D/Window/Camera2D"

signal window_closed 

var last_position: = Vector2i.ZERO
var velocity: = Vector2i.ZERO


func _ready() -> void:
	close_requested.connect(_on_window_close)
	# Set the anchor mode to "Fixed top-left"
	# Easier to work with since it corresponds to the window coordinates
	# print(DisplayServer.get_primary_screen())
	#DisplayServer.window_set_current_screen(0)
	#_Camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	
	transient = true # Make the window considered as a child of the main window
	close_requested.connect(queue_free) # Actually close the window when clicking the close button

func _process(delta: float) -> void:
	Globals.uiWindowPos = position
	velocity = position - last_position
	last_position = position
	#_Camera.position = get_camera_pos_from_window()
	#$Control.position.x = position.x
	#$Control.position.y = position.y
	

func get_camera_pos_from_window()->Vector2i:
	return position + velocity
	

	
func _on_window_close():
	self.duplicate()
	print("Window was closed!")
	Globals.save_data()
	window_closed.emit()  # Notify other nodes if needed
	#$"../Node2D/Window".queue_free()
	#$"../Window2".queue_free()
	queue_free()  # Remove window from the scene
