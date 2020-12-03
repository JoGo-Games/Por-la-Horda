extends Control

#Controlador del Menu Help
#Cambia a la escena correspondiente segun el botón presionado

var menu_controller
var previous_menu

func _ready():
	menu_controller = get_parent()

func _on_BackButton_pressed():
	menu_controller.animate_menu(1,previous_menu,"HelpMenu")


func _on_ControlButton_pressed():
	menu_controller.animate_menu(2,"ControlMenu","HelpMenu")


func _on_Guidebutton_pressed():
	menu_controller.animate_menu(2,"GuideMenu","HelpMenu")


func _on_StoryButton_pressed():
	menu_controller.animate_menu(2,"StoryMenu","HelpMenu")
