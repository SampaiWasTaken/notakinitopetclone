extends CharacterBody2D

@export var grav:int = 2000
@export var MAX_VEL : int = 600
@export var JUMP_SPEED : int = -700
@export var JUMP_VELOCITY = -700



func _ready() -> void:
	pass
	
func reset():
	rotation = 0

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("run")
	velocity.y += grav * delta
	
	if velocity.y > MAX_VEL:
		velocity.y = MAX_VEL

	move_and_slide()
	
		
func jump():
	velocity.y = JUMP_SPEED
