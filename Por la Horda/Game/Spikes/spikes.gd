tool
extends Area2D

#Controlador de los pinchos

func _on_spikes_body_entered(body): #Mata a Player si colisiona y hace que el enemigo voltee si colisiona con el
	if body.is_in_group("player"):
		body.die()
	elif body.is_in_group("enemy"):
		body.flip()