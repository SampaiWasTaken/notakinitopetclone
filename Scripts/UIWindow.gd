extends Window

@onready var _Camera: Camera2D = $"../Node2D/Window/Camera2D"

var last_position: = Vector2i.ZERO
var velocity: = Vector2i.ZERO

func _ready() -> void:
	# Set the anchor mode to "Fixed top-left"
	# Easier to work with since it corresponds to the window coordinates
	# print(DisplayServer.get_primary_screen())
	#DisplayServer.window_set_current_screen(0)
	#_Camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	
	transient = true # Make the window considered as a child of the main window
	close_requested.connect(queue_free) # Actually close the window when clicking the close button

func _process(delta: float) -> void:
	
	velocity = position - last_position
	last_position = position
	#_Camera.position = get_camera_pos_from_window()
	#$Control.position.x = position.x
	#$Control.position.y = position.y
	

func get_camera_pos_from_window()->Vector2i:
	return position + velocity
	

	


func _on_control_game_btn_pressed() -> void:
	
	pass # Replace with function body.
