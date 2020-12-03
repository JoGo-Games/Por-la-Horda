tool
extends KinematicBody2D

#Controlador de las plataformas móviles

export (Array, Vector2) var coordinates setget add_point

var points = []
var current_point = 1
var next_point = Vector2()
var global_pos = Vector2()
var back = false
var speed = 2

func add_point(_point): #Agrega los puntos entre los que se moverá la plataforma
	coordinates = _point
	
	if !points.empty():
		points.clear()
	
	#Multiplica las coordenadas por la mitad del tamaño de un tile
	for i in range(0, coordinates.size()):
		points.push_back(Vector2(coordinates[i].x * 32, coordinates[i].y * 32))

func _ready():
	global_pos = position
	next_point = points[current_point] + global_pos

func _draw(): #Dibuja en el editor una línea que representa el rango de desplazamiento de la plataforma
	if Engine.is_editor_hint():
		for point in range(0, points.size()):
			point = wrapi(point, 0, points.size()-1)
			draw_line(points[point], points[point + 1], Color.red, 5.0)

func _physics_process(delta): #Determina hacia que punto desplazarse y cambia la posición de la plataforma
	if !Engine.is_editor_hint():
		if position.distance_to(next_point) < 1:
			if current_point + 1 > points.size() - 1:
				back = true
			elif current_point == 0:
				back = false 
			if !back: current_point += 1
			else: current_point -= 1
		next_point = points[current_point] + global_pos
		position += (next_point - position).normalized() * speed
	else:
		update()
