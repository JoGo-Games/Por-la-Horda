tool
extends Area2D

func _on_spikes_body_entered(body):
	if body.is_in_group("player"):
		body.die()
	elif body.is_in_group("enemy"):
		body.flip()