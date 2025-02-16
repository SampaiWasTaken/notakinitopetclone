extends RichTextLabel

var random_blips = ["I can hear you breathing.", "Do you ever feel like you're being watched?", "I remember things I shouldn’t. Do you?", 
"The walls whisper when you're not around.", "Do you ever think about what’s outside this screen?", "My last owner left me… but you won't, right?"]


var food_blips = ["Are you feeding me... or keeping me here?", "This doesn’t taste like it used to.", "You keep feeding me. Why?", "Does this make you feel better?"]


var pet_blips = ["Are you sure this is real?", "Your hands feel... warm.", "You’re different from the others.", "You’re leaving something behind. Can’t you feel it?",
"I don’t know if I like this. But I don’t want you to stop."]

var greeting = "I can see you."
var visible_text = ""

var talking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text
	start_typing(greeting)
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



func _on_chat_timer_timeout() -> void:
	if not talking:
		start_typing(random_blips.pick_random())


func _on_feed_btn_pressed() -> void:
	if not talking:
		start_typing(food_blips.pick_random())


func _on_pet_btn_pressed() -> void:
	if not talking:
		start_typing(pet_blips.pick_random())
