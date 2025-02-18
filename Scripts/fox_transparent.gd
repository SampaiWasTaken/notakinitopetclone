extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func petFox() -> void:
	$Fox.play("pet")

func runFox() -> void:
	$Fox.play("run")

func _on_fox_animation_finished() -> void:
	$Fox.play("idle")


func _on_control_pet_btn_pressed() -> void:
	petFox()
	pass # Replace with function body.


func _on_control_feed_btn_pressed() -> void:
	feedFox()
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


func _on_control_game_btn_pressed() -> void:
	pass # Replace with function body.


func _on_pet_btn_pressed() -> void:
	petFox()
	pass # Replace with function body.


func _on_feed_btn_pressed() -> void:
	feedFox()
	pass # Replace with function body.


func _on_game_btn_pressed() -> void:
	
	pass # Replace with function body.

func feedFox():
	$StaticBody2D/Fox.play("food")
	#emit_signal("feedBtnPressed")
	var food = preload("res://food.tscn").instantiate()
	food.randomize_food()
	food.position = $FoodMarker.position
	food.scale = Vector2(5,5)
	add_child(food)
	await get_tree().create_timer(1.6).timeout
	food.queue_free()
