extends Control

#Controlador de todos los menues del juego, se encarga de animarlos y cambiarlos

signal score
var index
var menu
var previous_menu
var animated = false
var next_scene 
var changing = false
var resuming = false
var soundon = true

func back_menu(): #Cambia al menu mostrado antes del menu actual
	get_node(previous_menu).visible = false
	get_node(menu).visible = true
	$AnimationPlayer.play_backwards("Fade")

func change_menu(): #Cambia al menu indicado
	get_node(previous_menu).visible = false
	var current_menu = get_node(menu)
	current_menu.visible = true
	current_menu.previous_menu = previous_menu
	$AnimationPlayer.play_backwards("Fade")
	
func change_score_menu(): #Cambia al menu que muestra los puntajes, emite la señal que hace que se cargen los puntajes
	get_node(previous_menu).visible = false
	var scoremenu = get_node(menu)
	scoremenu.visible = true
	scoremenu.previous_menu = previous_menu
	$AnimationPlayer.play_backwards("Fade")
	emit_signal("score")

func change_scene(_scene,_index): #Cambia a la escena indicada
	if soundon:
		$ButtonSound.play()
	next_scene = _scene
	index = _index
	changing = true
	$AnimationPlayer.play("Fade")

func change_scene_now(): #Luego de terminada la animación del menu cambia la escena
	global.change_scene(next_scene,index)

func animate_menu(_index,_menu,_previous_menu = null): #Setea las variables con los parámetros obtenidos y anima el menu
	$ButtonSound.play()
	index = _index
	menu = _menu
	previous_menu = _previous_menu
	animated = true
	$AnimationPlayer.play("Fade")

func set_menu(_index): #Segun el index obtenido, llama a la función correspondiente
	match _index:
		1:
			back_menu()
		2:
			change_menu()
		3:
			change_score_menu()

func _on_AnimationPlayer_animation_finished(anim_name): #Determina la acción siguiente
	soundon = true
	if resuming: #Continúa con el juego
		self.visible = false
		get_tree().paused = false
		resuming = false
	if changing: #Cambia de escena
		change_scene_now()
		changing = false
	if animated: #Cambia de menu
		set_menu(index)
		animated = false
