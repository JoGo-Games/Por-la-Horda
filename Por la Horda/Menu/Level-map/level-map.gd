extends Area2D

#Controlador de los seleccionadores de niveles en el Menu Mapa
#Muestra la textura correspondiente si esta desbloqueado o bloqueado y guarda los puntajes para 2 y 3 estrellas

export (Array,int) var bestscore
export (Array,int) var midscore
var unlocked = true

func level_locked():
	unlocked = false
	$Sprite.texture.region = Rect2(0, 123, 180, 123)

func level_unlocked():
	unlocked = true
	$Sprite.texture.region = Rect2(0,0,180,123)