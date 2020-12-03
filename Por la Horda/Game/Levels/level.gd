tool
extends TileMap

#Controlador de Level

export (int) var level_buttons setget _set_level_buttons #Cantidad de botones en el nivel para abrir la puerta
export (Vector2) var player_position setget _set_player_position #Posición del player en la escena
export (Vector2) var door_position setget _set_door_position #Posición de la puerta en la escena
var player = null
var new_player = load("res://Game/Player/player.tscn")
var players:int #Cantidad de players utilizados
signal level_pass
signal player_dead

func _set_level_buttons(_buttons):
	level_buttons = _buttons

func _set_player_position(new_position):
	player_position = new_position
	if $player:
		$player.position = new_position

func _set_door_position(new_position):
	door_position = new_position
	if $door:
		$door.position = new_position

func _ready():
	$player.position = player_position
	$player.connect("im_dead",self,"_on_player_im_dead")
	players = 1

func _on_player_im_dead(): #Emite la señal de muerte de player y crea un nuevo hijo player
		player = new_player.instance()
		add_child(player)
		player.position = player_position
		player.connect("im_dead",self,"_on_player_im_dead")
		emit_signal("player_dead")
		players += 1

func _button_pressed(): #Descuenta un boton de la cantidad necesaria para abrir la puerta y chequea si debe abrir la puerta
	level_buttons -= 1
	if level_buttons < 1:
		$door._open()

func _button_unpressed(): #Suma un botón a la cantidad necesaria para abrir la puerta
	level_buttons += 1
	$door._close()

func _on_door_level_pass(): #Emite la señal de nivel completo
	emit_signal("level_pass") 
