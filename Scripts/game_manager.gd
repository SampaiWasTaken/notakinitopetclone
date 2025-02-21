extends Node

var file_path = "user://hello.txt"  # This will save in the game's user directory
var file = FileAccess.open(file_path, FileAccess.WRITE)
var executed = false
var picks = [0, 1, 2, 3]
var thr1 = Thread.new()
var thr2 = Thread.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.foxmad == true:
		if not executed:
			executed = true
			while not picks.is_empty():
				await get_tree().create_timer(randf_range(5, 5)).timeout  
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

func randomizeEvents():
	if picks.is_empty():
		pass
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
	pass

func _exit_tree():
	thr1.wait_to_finish()
	thr2.wait_to_finish()
