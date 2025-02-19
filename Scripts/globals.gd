extends Node

signal updated_food
signal updated_fun
signal updated_love

#global Variables 
var food = 50
var fun = 50
var love = 50

@export var min_decrease: int = 1  # Minimum amount to decrease
@export var max_decrease: int = 5 # Maximum amount to decrease
@export var interval: float = 180 # Time in seconds (3 minutes)


func _ready():
	var timer = Timer.new()
	timer.wait_time = interval
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout():
	var decrease_amount1 = randi_range(min_decrease, max_decrease)
	var decrease_amount2 = randi_range(min_decrease, max_decrease)
	var decrease_amount3 = randi_range(min_decrease, max_decrease)
	addFood(decrease_amount1*-1)
	addFun(decrease_amount2*-1)
	addLove(decrease_amount3*-1)
	

func addFood(amount:float):
	food = food + amount
	if food > 100:
		food = 100
	elif food < 0:
		food = 0
	emit_signal("updated_food")

func addFun(amount:float):
	fun = fun + amount
	if fun > 100:
		fun = 100
	elif fun < 0:
		fun = 0
	emit_signal("updated_fun")

func addLove(amount:float):
	love = love + amount
	if love > 100:
		love = 100
	elif love < 0:
		love = 0
	emit_signal("updated_love")
