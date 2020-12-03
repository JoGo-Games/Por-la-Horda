extends Node2D

#Controlador de la puerta de los niveles

var open:bool = false
var knocks = false #variable para saber si el jugador es quien está sobre la puerta
signal level_pass

func _ready():
	pass

func _open(): #Anima la puerta y reproduce el sonido de apertura
	if !open:
		$DoorSound.play()
		open = true
		$AnimatedSprite.play("open")
		if knocks: #Si player esta sobre la puerta, emite la señal de nivel completado
			emit_signal("level_pass")

func _close(): # Anima la puerta y reproduce el sonido de cierre
	if open:
		$DoorSound.play()
		open = false
		$AnimatedSprite.play("close")

func _on_Area2D_body_entered(body): #Chequea si el cuerpo que ingresa en el área es player
	if body.is_in_group("player"):
		knocks = true
		if open: #En caso de que la puerta esté abierat emite la señal de nivel completado
			emit_signal("level_pass")

func _on_Area2D_body_exited(body): #Chequa cuando player deja de colisionar con el área 
	if body.is_in_group("player"):
		knocks = false