extends Control

var menu_controller
var sound = true
var music = true
var previous_menu

func change_sound(_sound):
		_on_Sound_pressed()

func change_music(_music):
		_on_Music_pressed()

func _ready():
	menu_controller = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	self.visible = false;
	menu_controller.back_menu(previous_menu)


func _on_Sound_pressed():
	sound = !sound
	if sound:
		$Background/VBoxContainer/HBoxContainer/Sound.texture_normal.region = Rect2(0,0,300,150)
	else:
		$Background/VBoxContainer/HBoxContainer/Sound.texture_normal.region = Rect2(300,0,300,150)


func _on_Music_pressed():
	music = !music
	if music:
		$Background/VBoxContainer/HBoxContainer2/Music.texture_normal.region = Rect2(0,0,300,150)
	else:
		$Background/VBoxContainer/HBoxContainer2/Music.texture_normal.region = Rect2(300,0,300,150)