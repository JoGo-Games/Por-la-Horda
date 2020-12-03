extends Control

#Controlador de la GUI

signal pause
var str_elapsed

func _on_PauseButton_pressed(): #Emite la señal de la pausa del juego
	emit_signal("pause")

func set_time(_minutes, _seconds): #Actualiza y muestra el tiempo transcurrido en pantalla
	if _seconds < 10 && _minutes < 10:
		str_elapsed = "0%d:0%.2f" % [_minutes,_seconds]
	if _seconds < 10 && _minutes > 10:
		str_elapsed = "%d:0%.2f" % [_minutes,_seconds]
	if _seconds > 10 && _minutes < 10:
		str_elapsed = "0%d:%.2f" % [_minutes,_seconds]
	if _seconds > 10 && _minutes > 10:
		str_elapsed = "%d:%.2f" % [_minutes,_seconds]
	$HBoxContainer/Time/TimeLabel.text = str_elapsed
	