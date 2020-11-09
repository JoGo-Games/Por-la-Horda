extends Node2D

var previous_position = Vector2()
var panning = false


func _ready():  
    set_process_input(true)

func _process(delta):
	if(!panning):
		if Input.is_action_just_pressed("ui_touch"):
			get_tree().set_input_as_handled()
			previous_position = get_local_mouse_position()
			panning = true
	
	if panning:
		position.x += get_local_mouse_position().x - previous_position.x
		if position.x > 0:
			position.x = 0
		elif position.x < -$Sprite.texture.get_width() + 1920:
			position.x = -$Sprite.texture.get_width() + 1920
		previous_position = get_local_mouse_position()
	
	if Input.is_action_just_released("ui_touch"):
		previous_position = Vector2()
		panning = false
