extends Area2D

#Controlador del Menu Map

var current_level = 1
var previous_position = Vector2()
var panning = false
export (int) var levels

func _ready():  #Establece los niveles desbloqueados
	$MusicMenu.play()
	set_process_input(true)
	var j = 1
	while j < global.level_unlocked+1:
		var level_node_unlocked = "Maps/Level" + str(j)
		get_node(level_node_unlocked).level_unlocked()
		j+=1
	var i = global.level_unlocked+1
	while i <= levels:
		var level_node = "Maps/Level" + str(i)
		get_node(level_node).level_locked()
		i+=1

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Game/Levels/level" + str(current_level) + ".tscn")

func _input(event): #Permite el desplazamiento en el mapa horizontalmente
	if not panning:
		return
	
	if event.is_action_released("ui_touch"):
		previous_position = Vector2()
		panning = false
	
	if panning and event is InputEventScreenDrag:
		if $Maps.position.x <= 0 && $Maps.position.x >= -$Maps/Background.texture.get_width() + 1960:
			$Maps.position.x += event.position.x - previous_position.x
			previous_position = event.position
		if $Maps.position.x > 0:
			$Maps.position.x = 0
		if $Maps.position.x < -$Maps/Background.texture.get_width() + 1960:
			$Maps.position.x = -$Maps/Background.texture.get_width() + 1960

func _on_Map_input_event(viewport, event, shape_idx): #Detecta el paneo del mapa
	if event is InputEventScreenTouch:
		get_tree().set_input_as_handled()
		previous_position = event.position
		panning = true

func _on_Level1_input_event(viewport, event, shape_idx): #Cambia la posición del sprite del player al nivel 1 y setea el menu
	if event.is_action_pressed("ui_touch"):
		$Maps/Player.position = $Maps/Level1.position + Vector2(10,-40)
		current_level = 1
		global.current_level = current_level
		set_menu("Level 1")

func _on_Level2_input_event(viewport, event, shape_idx): #Cambia la posición del sprite del player al nivel 2 y setea el menu
	if global.level_unlocked >= 2:
		if event.is_action_pressed("ui_touch"):
			$Maps/Player.position = $Maps/Level2.position + Vector2(10,-40)
			current_level = 2
			global.current_level = current_level
			set_menu("Level 2")

func _on_Level3_input_event(viewport, event, shape_idx): #Cambia la posición del sprite del player al nivel 3 y setea el menu
	if global.level_unlocked >= 3:
		if event.is_action_pressed("ui_touch"):
			$Maps/Player.position = $Maps/Level3.position + Vector2(10,-40)
			current_level = 3
			global.current_level = current_level
			set_menu("Level 3")

func _on_Level4_input_event(viewport, event, shape_idx): #Cambia la posición del sprite del player al nivel 4 y setea el menu
	if global.level_unlocked >= 4:
		if event.is_action_pressed("ui_touch"):
			$Maps/Player.position = $Maps/Level4.position + Vector2(10,-40)
			current_level = 4
			global.current_level = current_level
			set_menu("Level 4")

func _on_Level5_input_event(viewport, event, shape_idx): #Cambia la posición del sprite del player al nivel 5 y setea el menu
	if global.level_unlocked >= 5:
		if event.is_action_pressed("ui_touch"):
			$Maps/Player.position = $Maps/Level5.position + Vector2(10,-40)
			current_level = 5
			global.current_level = current_level
			set_menu("Level 5")

func set_menu(_level): #Setea el menú y lo muestra en pantalla
	$Menu/ButtonSound.play()
	$Menu.visible = true
	$Menu/AnimationPlayer.play_backwards("Fade")
	$Menu/LevelMenu.set_level(_level)

func _on_LevelMenu_play(): #Cambia a la escena Game pasandole los parámetros del nivel seleccionado
	$PlaySound.play()
	$Menu.soundon = false
	global.set_current_score(get_node("Maps/Level"+str(current_level)).bestscore,1)
	global.set_current_score(get_node("Maps/Level"+str(current_level)).midscore,2)
	$Menu.change_scene("Game",current_level)

func _on_Menu_score(): #Muestra el Menu Score y le asigna los valores correspondientes al nivel seleccionado
	var level_node = get_node("Maps/Level"+str(current_level))
	var str_bestscore
	var str_midscore
	if level_node.bestscore[1] < 10:
		str_bestscore = "0%d:0%.2f" % [level_node.bestscore[0],level_node.bestscore[1]]
	else:
		str_bestscore = "0%d:%.2f" % [level_node.bestscore[0],level_node.bestscore[1]]
	if level_node.midscore[1] < 10:
		str_midscore = "0%d:0%.2f" % [level_node.midscore[0],level_node.midscore[1]]
	else:
		str_midscore = "0%d:%.2f" % [level_node.midscore[0],level_node.midscore[1]]
	$Menu/ScoreMenu.set_score(str_bestscore,str_midscore)

func _on_LevelMenu_exit():
	$Menu/ButtonSound.play()
	$Menu/AnimationPlayer.play("Fade")

func _on_TextureButton_pressed():
	global.change_scene("MainMenu",0)