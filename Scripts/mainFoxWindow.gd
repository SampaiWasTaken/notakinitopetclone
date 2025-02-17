extends Window

@onready var _Camera: Camera2D = $Camera2D



var last_position: = Vector2i.ZERO
var velocity: = Vector2i.ZERO
@export var keepFoxInFrame = true
@export var currentPosi:Vector2



func _ready() -> void:
	$FoxTransparent.visible = false
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
		position.x = $"../../Window3".position.x
		position.y = $"../../Window3".position.y + 300
	
	#print($Node2D/StaticBody2D/Fox.position)
	#position = $"..".position
	
	

func get_camera_pos_from_window()->Vector2i:
	return position + velocity
	
func set_pos():
	keepFoxInFrame = false
	jump_window(Vector2i(400, 0), 0.5)

func jump_window(offset: Vector2i, duration: float):
	var tween = get_tree().create_tween()
	var start_pos = position
	var peak_pos = start_pos + offset / 2 + Vector2i(0, -100)  # Midway up
	var end_pos = start_pos + offset  # Final landing position
	$"../../Window3/Control".toggleFoxVisibility(false)
	$FoxTransparent.visible = true
	$FoxTransparent.runFox()
	# Move up and forward
	tween.tween_property($".", "position", peak_pos, duration / 2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# Move down and land
	tween.tween_property($".", "position", end_pos, duration / 2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	await tween.finished
	
	$FoxTransparent.petFox()
	
	
	
func _on_control_feed_btn_pressed() -> void:
	set_pos()
	pass # Replace with function body.
