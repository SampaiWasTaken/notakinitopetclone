extends Node

var file_path = "user://hello.txt"  # This will save in the game's user directory
var file = FileAccess.open(file_path, FileAccess.WRITE)
var executed = false
var picks = [0, 1, 2, 3]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.foxmad == true:
		if not executed:
			executed = true
			#creepy()
	pass


func notepadNote():
	file.store_string("Hello, %s.\nAre you still watching me?" % OS.get_environment("USERNAME"))
	file.close()
	
	OS.shell_open(ProjectSettings.globalize_path(file_path))

func cmdTest():
	OS.execute("cmd.exe", ["/C", "start", "cmd", "/C", "echo I'm inside your walls && pause"], [], false, true)

func creepy():
	await get_tree().create_timer(randf_range(25, 50)).timeout  
	randomizeEvents()

func randomizeEvents():
	if picks.is_empty():
		pass
	var picked = picks.pick_random()
	picks.erase(picked)
	
	match picked:
		0:
			var thr = Thread.new()
			thr.start(cmdTest)
			$"../InsideTheWalls".play()
		1:
			OS.execute("explorer", ["https://www.yyyyyyy.info/"], ["--new-window"], false, true)
		2:
			OS.alert("Are you sure you're alone?", "Hello?")
		3:
			notepadNote()
	pass
