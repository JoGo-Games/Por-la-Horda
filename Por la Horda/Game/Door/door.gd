extends Node2D

var open:bool = false
var knocks = false
signal level_pass
func _ready():
	pass

func _open():
	if !open:
		open = true
		$AnimatedSprite.play("open")
		if knocks:
			emit_signal("level_pass")

func _close():
	if open:
		open = false
		$AnimatedSprite.play("close")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		knocks = true
		if open:
			emit_signal("level_pass")


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		knocks = false