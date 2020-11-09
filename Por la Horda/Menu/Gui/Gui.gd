extends Control

signal pause
var str_elapsed

func _on_PauseButton_pressed():
	emit_signal("pause")

func set_time(_minutes, _seconds):
	if _seconds < 10 && _minutes < 10:
		str_elapsed = "0%d:0%.2f" % [_minutes,_seconds]
	if _seconds < 10 && _minutes > 10:
		str_elapsed = "%d:0%.2f" % [_minutes,_seconds]
	if _seconds > 10 && _minutes < 10:
		str_elapsed = "0%d:%.2f" % [_minutes,_seconds]
	if _seconds > 10 && _minutes > 10:
		str_elapsed = "%d:%.2f" % [_minutes,_seconds]
	$HBoxContainer/Time/TimeLabel.text = str_elapsed
	