extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func petFox() -> void:
	$StaticBody2D/Fox.play("pet")

func runFox() -> void:
	$StaticBody2D/Fox.play("run")

func _on_fox_animation_finished() -> void:
	$StaticBody2D/Fox.play("idle")


func _on_control_pet_btn_pressed() -> void:
	petFox()
	pass # Replace with function body.


func _on_control_feed_btn_pressed() -> void:
	pass # Replace with function body.


	

func _on_static_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("WTF")
	print(InputEvent)
	pass # Replace with function body.
