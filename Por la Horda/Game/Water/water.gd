tool
extends Node2D

#Script encargado de la creación de ríos de diferentes tipos, estableciendo
#el daño que produce al jugador y las dimensiones de los sprites

export (Vector2) var size = Vector2(1, 1) setget _change_size
export var tileSize = 64

var rectSprite = Vector2()
var back_water : Sprite
var front_water : Sprite
var color

#Cambia las dimensiones
func _change_size(_size):
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
	#Sprite mas bajo que el del fondo
	front_water.region_rect = Rect2(35, 0, rectSprite.x, rectSprite.y - 20)
	front_water.position += Vector2(0, 10)
	#Movimiento de las olas
	front_water.material.set_shader_param("speed", 0.2)
	add_child(front_water)

	#Color según el tipo
	color = Color.aqua

	if back_water:
		back_water.modulate = color

	if front_water:
		front_water.modulate = color
		front_water.modulate.a = 0.70

#Establece los parámetros según las dimensiones
func setup():
	$Area2D.scale = size
	$Area2D.position = rectSprite / 2

#Crea el sprite y lo retorna
func create_sprite(zIndex):
	#Ancho y largo según la medida del tile y las dimensiones
	rectSprite = Vector2(tileSize * size.x, tileSize * size.y)

	#Crea el sprite con la textura
	var sprite = Sprite.new()
	sprite.texture = load("res://Game/Water/water.png")
	sprite.z_index = zIndex

	#Establece las medidas
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


func _on_Area2D_body_exited(body):
	body.swim()