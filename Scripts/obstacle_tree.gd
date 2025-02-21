extends Area2D
signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim = "tree" + str(randi_range(1, 3))
	$AnimatedSprite2D.play(anim)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	emit_signal("hit")
