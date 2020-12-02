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
var score

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
	$UI/Menucontroller/ButtonSound.play()
	get_tree().paused = true
	$UI/Menucontroller.visible = true
	$UI/Menucontroller/AnimationPlayer.play_backwards("Fade")

func _on_InGameMenu_restart():
	$UI/PlaySound.play()
	$UI/Menucontroller.soundon = false
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Game",0)

func _on_InGameMenu_exit():
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Map",0)

func on_playinglevel_level_pass():
	$UI/VictorySound.play()
	get_tree().paused = true
	player_score = players_dead*10
	score_sec = seconds + player_score
	score_min = minutes
	if score_sec >= 60:
		score_min += 1
		score_sec -= 60
	score = score_min*60 + score_sec
	if score <= global.current_midscore_total:
		stars = 2
	if score <= global.current_bestscore_total:
		stars = 3
	if stars == 0:
		stars = 1
	if score > global.level_score["minscore_"+str(global.current_level)] *60 + global.level_score["secscore_"+str(global.current_level)]:
		global.level_score["minscore_"+str(global.current_level)] = score_min
		global.level_score["secscore_"+str(global.current_level)] = score_sec
		global.level_score["stars_"+str(global.current_level)] = stars
	$UI/Menucontroller/LevelPassMenu.set_score(minutes, seconds, score_min, score_sec, players_dead,stars)
	$UI/Menucontroller.visible = true
	$UI/Menucontroller/LevelPassMenu.visible = true
	$UI/Menucontroller/AnimationPlayer.play_backwards("Fade")
	if global.current_level == global.level_unlocked:
		global.level_unlocked += 1
	data.save_data()

func on_playinglevel_player_dead():
	players_dead += 1
	$UI/Gui/HBoxContainer/Lifes/LifesLabel.text = str(players_dead)

func _on_LevelPassMenu_restart():
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Game",0)

func _on_LevelPassMenu_exit():
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Map",0)

func _on_MainMenu_resume():
	$UI/Menucontroller/ButtonSound.play()
	$UI/Menucontroller.resuming = true
	$UI/Menucontroller/AnimationPlayer.play("Fade")

