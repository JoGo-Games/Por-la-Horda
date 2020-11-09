extends Node2D

var playinglevel
var players_dead = 0
var high_score
var score_min
var score_sec
var player_score
var time:float = 0.0
var seconds:float = 0.0
var minutes:int = 0
var stars = 0

func _ready():
	var newlevel = load("res://Game/Levels/Level" + str(global.current_level) + ".tscn")
	playinglevel = newlevel.instance()
	$Level.add_child(playinglevel)
	playinglevel.connect("level_pass",self,"on_playinglevel_level_pass")
	playinglevel.connect("player_dead",self,"on_playinglevel_player_dead")

func _process(delta):
	time += delta
	seconds = fmod(time,60)
	minutes = fmod(time,3600) /60
	$UI/Gui.set_time(minutes, seconds)

func _on_Gui_pause():
	get_tree().paused = true
	$UI/MainMenu.visible = true

func _on_InGameMenu_restart():
	change_scene("Game",0)

func _on_InGameMenu_exit():
	change_scene("Map",1)

func on_playinglevel_level_pass():
	get_tree().paused = true
	player_score = players_dead*10
	score_sec = seconds + player_score
	score_min = minutes
	if score_sec > 60:
		score_min += 1
		score_sec -= 60
	if score_min <= global.current_bestscore[0] && score_sec <= global.current_bestscore[1]:
		stars = 3
	if score_min <= global.current_midscore[0] && score_sec <= global.current_midscore[1]:
		stars = 2
	if stars == 0:
		stars = 1
	$UI/LevelPassMenu.set_score(minutes, seconds, score_min, score_sec, players_dead,stars)
	$UI/LevelPassMenu.visible = true
	

func on_playinglevel_player_dead():
	players_dead += 1
	$UI/Gui/HBoxContainer/Lifes/LifesLabel.text = str(players_dead)

func _on_LevelPassMenu_restart():
	change_scene("Game",0)

func _on_LevelPassMenu_exit():
	change_scene("Map",1)

func change_scene(_scene, _index):
	get_tree().paused = false
	global.change_scene(_scene,_index)
