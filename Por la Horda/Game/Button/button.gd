extends Area2D

#Controlador de los botones de las puertas de los niveles

var colliding:int = 0 #Contador para saber cuantos cuerpos están sobre el botón 
var pressedsfx = load("res://Sfx/Button-Pressed.ogg")
var unpressedsfx = load("res://Sfx/Button-Unpressed.ogg")

func _on_button_body_entered(body):
	if colliding < 1: #Presiona el botón y reproduce el sonido si no está siendo presionado
		$ButtonSound.stream = pressedsfx
		$ButtonSound.play()
		$AnimatedSprite.play("pressed")
		get_owner()._button_pressed()
	colliding += 1


func _on_button_body_exited(body):
	colliding -= 1
	if colliding < 1: #Suelta el botón y reproduce el sonido cuando no quedan cuerpos sobre éste
		$ButtonSound.stream = unpressedsfx
		$ButtonSound.play()
		$AnimatedSprite.play("unpressed")
		get_owner()._button_unpressed()