extends Control

var menu_controller
signal restart
signal exit

func _ready():
	menu_controller = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ResumeButton_pressed():
	visible = false;
	get_tree().paused = false

func _on_RestartButton_pressed():
	emit_signal("restart")


func _on_OptionsButton_pressed():
	self.visible = false;
	menu_controller.change_menu("OptionsMenu","MainMenu")


func _on_ExitButton_pressed():
	emit_signal("exit")


func _on_ScoreButton_pressed():
	self.visible = false;
	menu_controller.change_score_menu("ScoreMenu","MainMenu")