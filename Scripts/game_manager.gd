extends Node

var file_path = "user://mystery_note.txt"  # This will save in the game's user directory
var file = FileAccess.open(file_path, FileAccess.WRITE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#notepadNote()
	
	var thr = Thread.new()
	await get_tree().create_timer(randf_range(5, 5)).timeout  
	OS.execute("explorer", ["https://www.yyyyyyy.info/"], ["--new-window"], false, true)
	#OS.execute("taskkill", ["/f", "/im", "explorer.exe"], [], false, true)
	#OS.execute("explorer.exe", [],[], false, true)
	OS.alert("Are you sure you're alone?", "Hello?")
	thr.start(cmdTest)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func notepadNote():
	file.store_string("Hello, %s.\nAre you still watching me?" % OS.get_environment("USERNAME"))
	file.close()
	
	OS.shell_open(ProjectSettings.globalize_path(file_path))

func cmdTest():
	OS.execute("cmd.exe", ["/C", "start", "cmd", "/C", "echo I'm inside your walls && pause"], [], false, true)
