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
	set_music_sound(global.sound_on,global.music_on)
	menu_controller = get_parent()

func set_music_sound(_sound_on, _music_on):
	sound = _sound_on
	music = _music_on
	if _sound_on:
		$Background/VBoxContainer/HBoxContainer/Sound.texture_normal.region = Rect2(0,0,300,150)
	else:
		$Background/VBoxContainer/HBoxContainer/Sound.texture_normal.region = Rect2(300,0,300,150)
	if _music_on:
		$Background/VBoxContainer/HBoxContainer2/Music.texture_normal.region = Rect2(0,0,300,150)
	else:
		$Background/VBoxContainer/HBoxContainer2/Music.texture_normal.region = Rect2(300,0,300,150)

func _on_BackButton_pressed():
	menu_controller.animate_menu(1,previous_menu,"OptionsMenu")


func _on_Sound_pressed():
	sound = !sound
	if sound:
		$Background/VBoxContainer/HBoxContainer/Sound.texture_normal.region = Rect2(0,0,300,150)
	else:
		$Background/VBoxContainer/HBoxContainer/Sound.texture_normal.region = Rect2(300,0,300,150)
	global.set_sound(true)

func _on_Music_pressed():
	music = !music
	if music:
		$Background/VBoxContainer/HBoxContainer2/Music.texture_normal.region = Rect2(0,0,300,150)
	else:
		$Background/VBoxContainer/HBoxContainer2/Music.texture_normal.region = Rect2(300,0,300,150)
	global.set_music(true)