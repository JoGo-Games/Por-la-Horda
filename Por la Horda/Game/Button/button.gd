extends Area2D

var colliding:int = 0 

func _on_button_body_entered(body):
	if colliding < 1:
		$AnimatedSprite.play("pressed")
		get_owner()._button_pressed()
	colliding += 1


func _on_button_body_exited(body):
	colliding -= 1
	if colliding < 1:
		$AnimatedSprite.play("unpressed")
		get_owner()._button_unpressed()