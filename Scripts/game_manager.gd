extends Node

var file_path = "user://hello.txt"  # This will save in the game's user directory
var file = FileAccess.open(file_path, FileAccess.WRITE)
var executed = false
var picks = [0,1,2,3,4]
var thr1 = Thread.new()
var thr2 = Thread.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass

#TODO change timer  and enable
func _process(delta: float) -> void:
	if Globals.foxmad:
		if not picks.is_empty() and not executed:
			randomizeEvents()
	pass

func notepadNote():
	file.store_string("Hello, %s.\nAre you still watching me?" % OS.get_environment("USERNAME"))
	file.close()
	OS.shell_open(ProjectSettings.globalize_path(file_path))

func cmdTest():
	OS.execute("cmd.exe", ["/C", "start", "cmd", "/C", "echo I'm inside your walls && pause"], [], false, true)

func creepyError():
	OS.alert("Are you sure you're alone?", "Hello?")

func playvid():
	var cat = preload("res://Scenes/test.tscn").instantiate()
	cat.set("initial_position",1)
	add_child(cat)

func randomizeEvents():
	while not picks.is_empty():
		executed = true
		await get_tree().create_timer(randf_range(5, 5)).timeout
		var picked = picks.pick_random()
		picks.erase(picked)
		
		match picked:
			0:
				thr1.start(cmdTest)
				$"../InsideTheWalls".play()
			1:
				OS.execute("explorer", ["https://www.yyyyyyy.info/"], ["--new-window"], false, true)
			2:
				thr2.start(creepyError)
			3:
				notepadNote()
			4:
				playvid()
		 

func _exit_tree():
	thr1.wait_to_finish()
	thr2.wait_to_finish()
