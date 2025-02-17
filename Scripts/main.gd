extends Node
@onready var _MainWindow: Window = get_window()
@onready var _SubWindow: Window = $Window
@onready var _SubWindow2: Window = $Window2
@onready var _SubWindow3: Window = $Window3

func _ready():
	#_SubWindow.world_2d = _MainWindow.world_2d
	_SubWindow2.world_2d = _MainWindow.world_2d
	_SubWindow3.world_2d = _MainWindow.world_2d
