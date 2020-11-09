extends Control

var menu_controller
signal play
signal restart
signal exit
var str_score

func _ready():
	menu_controller = get_parent()

func set_level(_level):
	$MenuBackground/VBoxContainer/Level.text = str(_level)

func _on_ScoreButton_pressed():
	self.visible = false;
	menu_controller.change_score_menu("ScoreMenu","LevelMenu")

func _on_PlayButton_pressed():
	emit_signal("play")

func _on_CrossButton_pressed():
	menu_controller.visible = false

func _on_ReplayButton_pressed():
	emit_signal("restart")

func _on_MapButton_pressed():
	emit_signal("exit")

func set_score(_minutes, _seconds, _score_min, _score_sec, _players_dead, _stars):
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