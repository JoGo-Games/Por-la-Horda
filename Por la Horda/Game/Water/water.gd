tool
extends Node2D

#Controlador de los tiles de agua

export (Vector2) var size = Vector2(1, 1) setget _change_size #Setea el tamaño del agua
export var tileSize = 64 

var rectSprite = Vector2()
var back_water : Sprite
var front_water : Sprite
var color

func _change_size(_size): #Cambia las dimensiones 
	#Limita la altura
	if _size.y > 3: _size.y = 3
	size = _size

	#Crea el sprite del fondo y lo agrega a escena
	if back_water != null:
		back_water.queue_free()
	back_water = create_sprite(1)
	add_child(back_water)

	#Crea el sprite del frente y lo agrega a escena
	if front_water != null:
		front_water.queue_free()
	front_water = create_sprite(3)
	front_water.region_rect = Rect2(35, 0, rectSprite.x, rectSprite.y - 20)
	front_water.position += Vector2(0, 10)
	#Movimiento de las olas
	front_water.material.set_shader_param("speed", 0.2)
	add_child(front_water)
	color = Color.aqua

	if back_water:
		back_water.modulate = color

	if front_water:
		front_water.modulate = color
		front_water.modulate.a = 0.70

func setup(): #Establece los parámetros según las dimensiones
	$Area2D.scale = size
	$Area2D.position = rectSprite / 2

func create_sprite(zIndex): #Crea el sprite con las dimensiones multiplicadas por el tamaño de tile 
	rectSprite = Vector2(tileSize * size.x, tileSize * size.y)
	var sprite = Sprite.new()
	sprite.texture = load("res://Game/Water/water.png")
	sprite.z_index = zIndex
	sprite.region_enabled = true
	sprite.region_rect = Rect2(Vector2(0, 0), rectSprite)
	sprite.set_offset(Vector2(32 * size.x, 32 * size.y))
	#Agrega el shader
	var shader = ShaderMaterial.new()
	shader.set_shader(load("res://Game/Water/SpriteShader.shader"))
	sprite.set_material(shader)
	return sprite

func _ready():
	setup()

func _on_Area2D_body_entered(body):
	body.swim(position.y)
	$WaterSound.play()

func _on_Area2D_body_exited(body):
	$WaterSound.stop()
