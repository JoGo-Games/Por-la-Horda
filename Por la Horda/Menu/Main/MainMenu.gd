extends Control

var menu_controller

func _ready():
	menu_controller = get_parent()


func _on_playbutton_pressed():
	global.change_scene("Map",1)

func _on_optionsbutton_pressed():
	self.visible = false;
	menu_controller.change_menu("OptionsMenu","MainMenu")
