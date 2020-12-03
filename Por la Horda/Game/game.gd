extends Node2D

#Controlador de todos los objetos de los niveles

var playinglevel #Nivel actual
var players_dead = 0 #Contador de enemigos muertos
var high_score 
var score_min #Cantidad de minutos del score
var score_sec #Cantidad de segundos del score
var player_score #Score obtenido por la cantidad de muertes de players
var time:float = 0.0
var seconds:float = 0.0
var minutes:int = 0
var stars = 0 #estrellas obtenidas
var score #puntaje obtenido de sumar los 3 puntajes (minutos, segundos y players)

func _ready(): #Carga el nivel correspondiente
	var newlevel = load("res://Game/Levels/Level" + str(global.current_level) + ".tscn")
	playinglevel = newlevel.instance()
	$Level.add_child(playinglevel)
	playinglevel.connect("level_pass",self,"on_playinglevel_level_pass")
	playinglevel.connect("player_dead",self,"on_playinglevel_player_dead")

func _process(delta): #Actualiza el tiempo y lo muestra en la GUI
	time += delta
	seconds = fmod(time,60)
	minutes = fmod(time,3600) /60
	$UI/Gui.set_time(minutes, seconds)

func _on_Gui_pause(): #Pausa el juego y muestra el menú in game
	$UI/Menucontroller/ButtonSound.play()
	get_tree().paused = true
	$UI/Menucontroller.visible = true
	$UI/Menucontroller/AnimationPlayer.play_backwards("Fade")

func _on_InGameMenu_restart(): #Cambia de escena, a una nueva escena Game con los mismos atributos
	$UI/PlaySound.play()
	$UI/Menucontroller.soundon = false
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Game",0)

func _on_InGameMenu_exit(): #Cambia a la escena del Mapa
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Map",0)

func on_playinglevel_level_pass(): #Muestra el menu de victoria, con el puntaje y las estrellas obtenidas.
	#En caso de no haber completado el nivel anteriormente, desbloquea el nivel siguiente. Guarda los datos.
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

func on_playinglevel_player_dead(): #suma un player muerte
	players_dead += 1
	$UI/Gui/HBoxContainer/Lifes/LifesLabel.text = str(players_dead)

func _on_LevelPassMenu_restart(): #Cambia de escena, a una nueva escena Game con los mismos atributos
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Game",0)

func _on_LevelPassMenu_exit(): #Cambia a la escena del Mapa
	get_tree().paused = false
	$UI/Menucontroller.change_scene("Map",0)

func _on_MainMenu_resume(): #Quita el menú y continua en la misma escena de juego
	$UI/Menucontroller/ButtonSound.play()
	$UI/Menucontroller.resuming = true
	$UI/Menucontroller/AnimationPlayer.play("Fade")

