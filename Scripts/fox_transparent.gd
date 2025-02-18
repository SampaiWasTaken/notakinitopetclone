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
