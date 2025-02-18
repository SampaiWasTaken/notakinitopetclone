extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func petFox() -> void:
	$Area2D/Fox.play("pet")

func runFox() -> void:
	$Area2D/Fox.play("run")

func _on_fox_animation_finished() -> void:
	$Area2D/Fox.play("idle")


func _on_control_pet_btn_pressed() -> void:
	petFox()
	pass # Replace with function body.


func _on_control_feed_btn_pressed() -> void:
	pass # Replace with function body.


	

func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("WWWWWWWWWWWWWWWWWWWWWWWWW")
	pass # Replace with function body.


func _on_static_body_2d_mouse_entered() -> void:
	print("HUH ENTERED")
	pass # Replace with function body.


func _on_static_body_2d_mouse_exited() -> void:
	print("HUH EXITED")
	pass # Replace with function body.
