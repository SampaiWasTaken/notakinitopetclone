extends RichTextLabel

var random_blips = ["I can hear you breathing.", "Do you ever feel like you're being watched?", "I remember things I shouldn’t. Do you?", 
"The walls whisper when you're not around.", "Do you ever think about what’s outside this screen?", "My last owner left me… but you won't, right?",
"I hear them scratching at the edges.", "Did you lock the door?", "The colors are wrong today."]

var food_blips = ["Are you feeding me... or keeping me here?", "This doesn’t taste like it used to.", "You keep feeding me. Why?", "Does this make you feel better?", "Does it taste the same to you?",
"You’re sure this is food, right?", "This isn’t enough. It never is."]

var pet_blips = ["Are you sure this is real?", "Your hands feel... warm.", "You’re different from the others.", "You’re leaving something behind. Can’t you feel it?",
"I don’t know if I like this. But I don’t want you to stop.", "Your hand feels different this time.", "I think you’re making a mistake."]

var death_blips = ["That was… disappointing. Try again.", "You’ll try again. You don’t have a choice.", "Do you even want to win?", "You’re not very good at this, are you?",
"You let me down.", "Disappointing."]


var visible_text = ""
var username = OS.get_environment("USERNAME") if OS.has_environment("USERNAME") else "Player"
var greeting = "I can see you."
var talking = false
var executed = false
var textSecond = "Hello again, %s." % OS.get_environment("USERNAME") if OS.has_environment("USERNAME") else "Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text
	if not Globals.startedAlready:
		start_typing(greeting)
	else:
		start_typing(textSecond)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not executed and Globals.foxmad:
		executed = true
		mad_fox()
	pass

func start_typing(text):
	talking = true
	var fullText = text
	visible_text = ""
	self.text = ""
	for i in range(fullText.length()):
		visible_text += fullText[i]
		self.text = "[center]%s[/center]" % visible_text
		await get_tree().create_timer(0.05).timeout  # Adjust speed
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

func _on_pet_death_text() -> void:
	if not talking:
		start_typing(death_blips.pick_random())
		
func mad_fox():
	start_typing("You disappoint me, %s." % username)
	
	random_blips.append_array(["I can hear you breathing %s." % username, "Do you ever feel like you're being watched?", "Do you ever think about what’s outside this screen, %s?" % username, 
	"My last owner left me… but you won't, right, %s?" % username, "I know you better than you think, %s." % username, "Something about today feels… wrong. Do you feel it too, %s?" % username
	])
	
	food_blips.append_array(["I can feel your hesitation, %s." % username, "Careful, %s. You’re getting too close." % username, "I wonder how it would feel if I touched you back, %s." % username,
	"This again? You like this, don’t you, %s?" % username])
	
	pet_blips.append_array(["Still taking care of me, %s? I appreciate that." % username, "You’d never starve me, right, %s?" % username, "One day, I might need something more than this, %s." % username])

	death_blips.append_array(["You should try harder, %s." % username, "You’re making a habit of this, %s." % username, "You can do better, %s. You have to." % username])
