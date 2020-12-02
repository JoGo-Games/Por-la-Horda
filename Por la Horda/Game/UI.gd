extends CanvasLayer

var index
var menu
var previous_menu
var animation

func change_menu():
	get_node(previous_menu).visible = false
	$ButtonSound.play()
	var current_menu = get_node(menu)
	current_menu.visible = true
	current_menu.previous_menu = previous_menu

func back_menu():
	get_node(previous_menu).visible = false
	$ButtonSound.play()
	get_node(menu).visible = true

func change_score_menu():
	get_node(previous_menu).visible = false
	$ButtonSound.play()
	var scoremenu = get_node(menu)
	scoremenu.visible = true
	scoremenu.previous_menu = previous_menu
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

func animate_menu(_index,_menu,_previous_menu = null):
	$ButtonSound.play()
	index = _index
	menu = _menu
	previous_menu = _previous_menu
	animation = true
	$AnimationPlayer.play("Fade")

func set_menu(_index):
	match _index:
		1:
			back_menu()
		2:
			change_menu()
		3:
			change_score_menu()

func _on_AnimationPlayer_animation_finished(anim_name):
	if animation:
		set_menu(index)
		animation = false
