extends CharacterBody2D

@export var grav:int = 1000
@export var MAX_VEL : int = 600
@export var FLAP_SPEED : int = -100
var flying = false
var falling = false
const START_POS = Vector2(180,320)
@export var JUMP_VELOCITY = -75.0


func _ready() -> void:
	pass
	
func reset():
	falling = false
	flying = false
	position = START_POS
	rotation = 0

func _physics_process(delta: float) -> void:
	if flying or falling:
		velocity.y += grav * delta
	
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		
		if flying:
			rotation = deg_to_rad(velocity.y * 0.05)
			$AnimatedSprite2D.play("run")
		elif falling:
			rotation = PI/2
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()
		
func flap():
	velocity.y = FLAP_SPEED
