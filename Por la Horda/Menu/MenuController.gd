extends Control

signal score
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func back_menu(_menu):
	get_node(_menu).visible = true

func change_menu(_menu,_previous_menu):
	var current_menu = get_node(_menu)
	current_menu.visible = true
	current_menu.previous_menu = _previous_menu
	
func change_score_menu(_menu,_previous_menu):
	var scoremenu = get_node(_menu)
	scoremenu.visible = true
	scoremenu.previous_menu = _previous_menu
	emit_signal("score")