extends Control

#Controlador del Menu In Game
#Cambia a la escena correspondiente segun el botón presionado

var menu_controller
signal restart
signal exit
signal resume

func _ready():
	menu_controller = get_parent()

func _on_ResumeButton_pressed():
	emit_signal("resume")

func _on_RestartButton_pressed():
	emit_signal("restart")

func _on_OptionsButton_pressed():
	menu_controller.animate_menu(2,"OptionsMenu","MainMenu")

func _on_ExitButton_pressed():
	emit_signal("exit")

func _on_ScoreButton_pressed():
	menu_controller.animate_menu(3,"ScoreMenu","MainMenu")