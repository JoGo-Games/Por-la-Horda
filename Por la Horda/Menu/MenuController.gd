extends Control

signal score
var index
var menu
var previous_menu
var animated = false
var next_scene 
var changing = false
var resuming = false
var soundon = true

func back_menu():
	get_node(previous_menu).visible = false
	get_node(menu).visible = true
	$AnimationPlayer.play_backwards("Fade")

func change_menu():
	get_node(previous_menu).visible = false
	var current_menu = get_node(menu)
	current_menu.visible = true
	current_menu.previous_menu = previous_menu
	$AnimationPlayer.play_backwards("Fade")
	
func change_score_menu():
	get_node(previous_menu).visible = false
	var scoremenu = get_node(menu)
	scoremenu.visible = true
	scoremenu.previous_menu = previous_menu
	$AnimationPlayer.play_backwards("Fade")
	emit_signal("score")

func change_scene(_scene,_index):
	if soundon:
		$ButtonSound.play()
	next_scene = _scene
	index = _index
	changing = true
	$AnimationPlayer.play("Fade")

func change_scene_now():
	global.change_scene(next_scene,index)

func animate_menu(_index,_menu,_previous_menu = null):
	$ButtonSound.play()
	index = _index
	menu = _menu
	previous_menu = _previous_menu
	animated = true
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
	soundon = true
	if resuming:
		self.visible = false
		get_tree().paused = false
		resuming = false
	if changing:
		change_scene_now()
		changing = false
	if animated:
		set_menu(index)
		animated = false
