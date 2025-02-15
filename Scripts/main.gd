extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_control_pet_btn_pressed() -> void:
	$Fox.play("pet")

func _on_fox_animation_finished() -> void:
	$Fox.play("idle")
@onready var _MainWindow: Window = get_window()
@onready var _SubWindow: Window = $Window
@onready var _SubWindow2: Window = $Window2

func _ready():
	_SubWindow.world_2d = _MainWindow.world_2d
	_SubWindow2.world_2d = _MainWindow.world_2d
