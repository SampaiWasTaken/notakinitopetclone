extends Control
signal petBtnPressed
signal feedBtnPressed
signal gameBtnPressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pet_btn_pressed() -> void:
	emit_signal("petBtnPressed")


func _on_feed_btn_pressed() -> void:
	emit_signal("feedBtnPressed")
	pass


func _on_game_btn_pressed() -> void:
	emit_signal("gameBtnPressed")

func toggleFoxVisibility(x:bool) -> void:
	$FoxTransparent.visible=x


func _on_node_2d_2_game_over_text() -> void:
	$RichTextLabel._on_pet_death_text()
