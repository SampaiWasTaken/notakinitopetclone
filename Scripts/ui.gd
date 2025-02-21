extends Control
signal petBtnPressed
signal feedBtnPressed
signal gameBtnPressed
var petCD = false
var foodCD = false

var madFox = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	Globals.connect("updated_food", Callable(self, "_on_food_change"))
	Globals.connect("updated_fun", Callable(self, "_on_fun_change"))  
	Globals.connect("updated_love", Callable(self, "_on_love_change"))   
	
	$VBoxContainer/Food/TextureProgressBar.value = Globals.food
	$VBoxContainer/Game/TextureProgressBar.value = Globals.fun
	$VBoxContainer/Love/TextureProgressBar.value = Globals.love        
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.foxmad:
		$FoxTransparent.visible = false
	pass

func _on_pet_btn_pressed() -> void:
	if not petCD:
		petCD = true
		$petTimer.start()
		emit_signal("petBtnPressed")
		Globals.addLove(5)
		playBtnClick()
		$PetSound.play()

func _on_feed_btn_pressed() -> void:
	if not foodCD:
		foodCD = true
		$foodTimer.start()
		emit_signal("feedBtnPressed")
		Globals.addFood(5)
		playBtnClick()
		await get_tree().create_timer(0.25).timeout
		$FoodSound.play()

func _on_game_btn_pressed() -> void:
	emit_signal("gameBtnPressed")
	playBtnClick()

func toggleFoxVisibility(x:bool) -> void:
	$FoxTransparent.visible=x


func _on_node_2d_2_game_over_text() -> void:
	if not madFox:
		$RichTextLabel._on_pet_death_text()


func _on_node_2d_2_mad_fox() -> void:
	madFox = true
	$RichTextLabel.mad_fox()
	pass # Replace with function body.

func _on_food_change() -> void:
	$VBoxContainer/Food/TextureProgressBar.value = Globals.food
	
func _on_fun_change() -> void:
	$VBoxContainer/Game/TextureProgressBar.value = Globals.fun
	
func _on_love_change() -> void:
	$VBoxContainer/Love/TextureProgressBar.value = Globals.love
	
func _on_back_btn_pressed() -> void:
	$BtnContainer.visible = true
	$VBoxContainer.visible = false
	$BtnContainer2.visible = false
	playBtnClick()


func _on_stat_btn_2_pressed() -> void:
	$BtnContainer.visible = false
	$VBoxContainer.visible = true
	$BtnContainer2.visible = true
	playBtnClick()
	
func playBtnClick():
	$BtnClick.play()


func _on_pet_timer_timeout() -> void:
	petCD = false


func _on_food_timer_timeout() -> void:
	foodCD = false
