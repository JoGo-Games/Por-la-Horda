extends Area2D

var colliding:int = 0 
var pressedsfx = load("res://Sfx/Button-Pressed.ogg")
var unpressedsfx = load("res://Sfx/Button-Unpressed.ogg")

func _on_button_body_entered(body):
	if colliding < 1:
		$ButtonSound.stream = pressedsfx
		$ButtonSound.play()
		$AnimatedSprite.play("pressed")
		get_owner()._button_pressed()
	colliding += 1


func _on_button_body_exited(body):
	colliding -= 1
	if colliding < 1:
		$ButtonSound.stream = unpressedsfx
		$ButtonSound.play()
		$AnimatedSprite.play("unpressed")
		get_owner()._button_unpressed()