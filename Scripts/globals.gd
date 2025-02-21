extends Node

signal updated_food
signal updated_fun
signal updated_love
signal fox_dead_very_sad

#global Variables 
var food = 50
var fun = 50
var love = 50
var foxmad = false
var uiWindowPos = Vector2(0,0)
var startedAlready = false
var foxDied = false

@export var min_decrease: int = 1  # Minimum amount to decrease
@export var max_decrease: int = 7 # Maximum amount to decrease
@export var interval: float = 10 # Time in seconds (3 minutes)


func _ready():
	load_data()
	var timer = Timer.new()
	timer.wait_time = interval
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	if food <= 0 or love <= 0 or fun <= 0:
		food = 25
		love = 25
		fun = 25

func _on_timer_timeout():
	var decrease_amount1 = randi_range(min_decrease, max_decrease)
	var decrease_amount2 = randi_range(min_decrease, max_decrease)
	var decrease_amount3 = randi_range(min_decrease, max_decrease)
	addFood(decrease_amount1*-1)
	addFun(decrease_amount2*-1)
	addLove(decrease_amount3*-1)
	if food <= 0 or love <= 0 or fun <= 0:
		emit_signal("fox_dead_very_sad")
	

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
	
#storing DATA

func save_data():
	print("Saving Data")
	var save_dict = {
	"foxDied":foxDied,
	"food":food,
	"fun":fun,
	"love":love,
	"startedAlready": startedAlready,
	"foxmad": foxmad
	}
	print(save_dict)
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_dict))
	file.close()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()  # Save before quitting
		get_tree().quit()


#loading data
func load_data():
	print("loading Data")
	if FileAccess.file_exists("user://savegame.json"):
		var file = FileAccess.open("user://savegame.json", FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		var save_dict = JSON.parse_string(content)
		if save_dict:
			foxDied = save_dict.get("foxDied", false)
			food = save_dict.get("food", 0) # if food exists it loads value, if not it sets it to 0
			fun = save_dict.get("fun", 0)
			love = save_dict.get("love", 0)
			startedAlready = save_dict.get("startedAlready", false)
			foxmad = save_dict.get("foxmad", false)
