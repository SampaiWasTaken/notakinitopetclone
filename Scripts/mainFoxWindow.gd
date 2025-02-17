extends Window

@onready var _Camera: Camera2D = $Camera2D



var last_position: = Vector2i.ZERO
var velocity: = Vector2i.ZERO
@export var keepFoxInFrame = true
@export var currentPosi:Vector2

func _ready() -> void:
	# Set the anchor mode to "Fixed top-left"
	# Easier to work with since it corresponds to the window coordinates
	# print(DisplayServer.get_primary_screen())
	#DisplayServer.window_set_current_screen(0)
	_Camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	
	#transient = true # Make the window considered as a child of the main window
	close_requested.connect(queue_free) # Actually close the window when clicking the close button
	
	currentPosi = position

func _physics_process(delta: float) -> void:
	
	velocity = position - last_position
	last_position = position
	#_Camera.position = get_camera_pos_from_window()
	
	if keepFoxInFrame:
		currentPosi.x = $"../Window3".position.x
		currentPosi.y = $"../Window3".position.y + 250
	if !keepFoxInFrame:
		currentPosi.y = position.y + 100*delta
	#print($Node2D/StaticBody2D/Fox.position)
	position = currentPosi

func get_camera_pos_from_window()->Vector2i:
	return position + velocity
	
func set_pos():
	keepFoxInFrame = false
	#var tween = get_tree().create_tween()
	#DisplayServer.setposi
	#tween.tween_property(self, "position.x", 200, 2)
	set_ime_position(Vector2(200,200))
	


func _on_control_feed_btn_pressed() -> void:
	set_pos()
	pass # Replace with function body.
