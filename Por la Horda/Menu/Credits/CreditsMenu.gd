extends Control

#Controlador de Escena Credits

var menu_controller
var previous_menu

func _ready():
	menu_controller = get_parent()

func _on_BackButton_pressed():
	menu_controller.animate_menu(1,previous_menu,"CreditsMenu")
