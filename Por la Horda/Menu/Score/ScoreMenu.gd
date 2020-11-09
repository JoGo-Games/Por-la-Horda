extends Control

var menu_controller
var previous_menu

func _ready():
	menu_controller = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_BackButton_pressed():
	self.visible = false;
	menu_controller.back_menu(previous_menu)
	
func set_score(_bestscore,_midscore):
	$Background/VBoxContainer/HBoxContainer2/Time/TimeLabel.text = _midscore
	$Background/VBoxContainer/HBoxContainer3/Time/TimeLabel.text = _bestscore