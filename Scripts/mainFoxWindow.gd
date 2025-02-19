extends Window

@onready var _Camera: Camera2D = $Camera2D

var last_position: = Vector2i.ZERO
var velocity: = Vector2i.ZERO
@export var keepFoxInFrame = true
@export var currentPosi:Vector2

var dragging = false
var dragging_offset = Vector2.ZERO


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
	
	#physics_object_picking = true !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# needs to be true for area2d to work
	

func _physics_process(delta: float) -> void:
	
	velocity = position - last_position
	last_position = position
	#_Camera.position = get_camera_pos_from_window()
	
	if keepFoxInFrame:
		position.x = $"../../Window3".position.x
		position.y = $"../../Window3".position.y + 300
	
	if dragging:
		var mouse_pos = DisplayServer.mouse_get_position()
		position = mouse_pos - dragging_offset  # Update window position

func get_camera_pos_from_window()->Vector2i:
	return position + velocity
	
func set_pos():
	keepFoxInFrame = false
	jump_window(Vector2i(400, 0), 0.5)

func jump_window(offset: Vector2i, duration: float):
	$FoxTransparent.visible = true
	var tween = get_tree().create_tween()
	var start_pos = position
	var peak_pos = start_pos + offset / 2 + Vector2i(0, -100)  # Midway up
	var end_pos = start_pos + offset  # Final landing position
	$"../../Window3/Control".toggleFoxVisibility(false)
	$FoxTransparent.runFox()
	# Move up and forward
	tween.tween_property($".", "position", peak_pos, duration / 2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# Move down and land
	tween.tween_property($".", "position", end_pos, duration / 2).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	await tween.finished
	
	$FoxTransparent.petFox()
	
func _on_node_2d_2_mad_fox() -> void:
	set_pos()
	pass # Replace with function body.

func _on_fox_transparent_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			dragging = true
			dragging_offset = DisplayServer.mouse_get_position() - position
		else:
			dragging = false
