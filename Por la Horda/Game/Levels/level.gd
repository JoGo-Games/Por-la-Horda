tool
extends TileMap

export (Vector2) var player_position setget _set_position
var actual_player = null
var players = 2
var new_player = load("res://Game/Player/player.tscn")
var on_screen_players:int

func _set_position(new_position):
	player_position = new_position
	if $player:
		$player.position = new_position

func _ready():
	$player.position = player_position
	$player.connect("im_dead",self,"_on_player_im_dead")
	on_screen_players = 1

func _process(delta):
	pass

func _on_player_im_dead():
	if on_screen_players < players:
		actual_player = new_player.instance()
		add_child(actual_player)
		actual_player.position = player_position
		actual_player.connect("im_dead",self,"_on_player_im_dead")
		on_screen_players += 1