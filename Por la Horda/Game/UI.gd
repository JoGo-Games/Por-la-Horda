extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_menu(_menu,_previous_menu):
	var current_menu = get_node(_menu)
	current_menu.visible = true
	current_menu.previous_menu = _previous_menu

func back_menu(_menu):
	get_node(_menu).visible = true

func change_score_menu(_menu,_previous_menu):
	var scoremenu = get_node(_menu)
	scoremenu.visible = true
	scoremenu.previous_menu = _previous_menu
	var str_bestscore
	var str_midscore
	if global.current_bestscore[1] < 10:
		str_bestscore = "0%d:0%.2f" % [global.current_bestscore[0],global.current_bestscore[1]]
	else:
		str_bestscore = "0%d:%.2f" % [global.current_bestscore[0],global.current_bestscore[1]]
	if global.current_midscore[1] < 10:
		str_midscore = "0%d:0%.2f" % [global.current_midscore[0],global.current_midscore[1]]
	else:
		str_midscore = "0%d:%.2f" % [global.current_midscore[0],global.current_midscore[1]]
	$ScoreMenu.set_score(str_bestscore,str_midscore)