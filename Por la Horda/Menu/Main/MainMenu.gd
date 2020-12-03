extends Control

#Controlador del Menu Principal del juego

var menu_controller

func _ready():
	menu_controller = get_parent()

func _on_playbutton_pressed():
	menu_controller.change_scene("Map",1)

func _on_optionsbutton_pressed():
	menu_controller.animate_menu(2,"OptionsMenu","MainMenu")

func _on_creditsbutton_pressed():
	menu_controller.animate_menu(2,"CreditsMenu","MainMenu")

func _on_helpbutton_pressed():
	menu_controller.animate_menu(2,"HelpMenu","MainMenu")
