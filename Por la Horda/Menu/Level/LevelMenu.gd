extends Control

#Controlador del del Menu del nivel mostrado cuando se selecciona un nivel en el Mapa y del Menu de nivel completado

var menu_controller
signal play
signal restart
signal exit
var str_score

func _ready():
	menu_controller = get_parent()

func set_level(_level): #Carga los valores correspondientes al nivel
	$MenuBackground/VBoxContainer/Level.text = str(_level)
	set_highscore()

func _on_ScoreButton_pressed():
	menu_controller.animate_menu(3,"ScoreMenu","LevelMenu")

func _on_PlayButton_pressed():
	emit_signal("play")

func _on_CrossButton_pressed():
	emit_signal("exit")

func _on_ReplayButton_pressed():
	emit_signal("restart")

func set_highscore(): #Carga el puntaje máximo y la cantidad de estrellas obtenidas en el nivel
	var score_sec = global.level_score["secscore_"+str(global.current_level)]
	var score_min = global.level_score["minscore_"+str(global.current_level)]
	var stars = global.level_score["stars_"+str(global.current_level)]
	if score_sec < 10 && score_min < 10:
		str_score = "0%d:0%.2f" % [score_min,score_sec]
	if score_sec < 10 && score_min > 10:
		str_score = "%d:0%.2f" % [score_min,score_sec]
	if score_sec > 10 && score_min < 10:
		str_score = "0%d:%.2f" % [score_min,score_sec]
	if score_sec > 10 && score_min > 10:
		str_score = "%d:%.2f" % [score_min,score_sec]
	$MenuBackground/VBoxContainer/HighScoreBackground/HighScore.text = str_score
	if stars == 3:
		$MenuBackground/VBoxContainer/Stars.texture.region = Rect2(0, 750, 600, 250)
	if stars == 2:
		$MenuBackground/VBoxContainer/Stars.texture.region = Rect2(0, 500, 600, 250)
	if stars == 1:
		$MenuBackground/VBoxContainer/Stars.texture.region = Rect2(0, 250, 600, 250)
	if stars == 0:
		$MenuBackground/VBoxContainer/Stars.texture.region = Rect2(0, 0, 600, 250)

func set_score(_minutes, _seconds, _score_min, _score_sec, _players_dead, _stars): #Establece el puntaje obtenido en al completar el nivel
	if _seconds < 10 && _minutes < 10:
		str_score = "0%d:0%.2f" % [_minutes,_seconds]
	if _seconds < 10 && _minutes > 10:
		str_score = "%d:0%.2f" % [_minutes,_seconds]
	if _seconds > 10 && _minutes < 10:
		str_score = "0%d:%.2f" % [_minutes,_seconds]
	if _seconds > 10 && _minutes > 10:
		str_score = "%d:%.2f" % [_minutes,_seconds]
	$MenuBackground/VBoxContainer/Scoreboard/Summation/Time/TimeLabel.text = str_score
	var player_score = _players_dead *10
	$MenuBackground/VBoxContainer/Scoreboard/Summation/PlayersDead/PlayerScore.text = "x " + str(_players_dead) + " = " + str(player_score)
	if _score_sec < 10 && _score_min < 10:
		str_score = "0%d:0%.2f" % [_score_min,_score_sec]
	if _score_sec < 10 && _score_min > 10:
		str_score = "%d:0%.2f" % [_score_min,_score_sec]
	if _score_sec > 10 && _score_min < 10:
		str_score = "0%d:%.2f" % [_score_min,_score_sec]
	if _score_sec > 10 && _score_min > 10:
		str_score = "%d:%.2f" % [_score_min,_score_sec]
	$MenuBackground/VBoxContainer/Scoreboard/Score/HighScoreBackground/HighScore.text = str_score
	match _stars:
		3:
			$MenuBackground/VBoxContainer/Scoreboard/Score/Stars.texture.region = Rect2(0, 750, 600, 250)
		2:
			$MenuBackground/VBoxContainer/Scoreboard/Score/Stars.texture.region = Rect2(0, 500, 600, 250)
		1:
			$MenuBackground/VBoxContainer/Scoreboard/Score/Stars.texture.region = Rect2(0, 250, 600, 250)

func _on_MapButton_pressed():
	emit_signal("exit")
