extends RichTextLabel

var death_blips = ["That was… disappointing. Try again.", "You’ll try again. You don’t have a choice.", "Do you even want to win?", "You’re not very good at this, are you?",
"You let me down.", "Disappointing."]

var visible_text = ""

var username = OS.get_environment("USERNAME") if OS.has_environment("USERNAME") else "Player"
var goodbye = "Where are you going?"

var talking = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text
	start_typing(goodbye)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_typing(text):
	talking = true
	var fullText = text
	visible_text = ""
	self.text = ""
	for i in range(fullText.length()):
		visible_text += fullText[i]
		self.text = "[center]%s[/center]" % visible_text
		await get_tree().create_timer(0.07).timeout  # Adjust speed
	talking = false
	await get_tree().create_timer(1).timeout
	get_tree().quit()
