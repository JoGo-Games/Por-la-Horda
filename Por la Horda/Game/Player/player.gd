tool
extends KinematicBody2D

#Controlador de Player

signal im_dead

const GRAVITY = 800 
var WATER_GRAVITY = 25
const speed = 200.0 
const swim_speed = 100.0 
const jump_speed = 600
var move = Vector2.ZERO
export var alive = true #Variable para determinar si sigue vivo o si colisiono con un elemento que lo mató
var dead = false  #Variable para determinar si está animando su muerte
var direction:int
var swimming = false #Variable para determinar las fuerzas que afectan al jugador dentro del agua
var water_top #Coordenada Y superior del tile del agua
var floating = false #Determina si esta dentro del agua para evitar que salte
var flip = false
var capsuleshape = load("res://Game/Player/capsule_shape_2d.tres") #Figura de colisión para cuando muere
var capsule_height = 0
var snap = Vector2(0,32)
var is_static = false #Variable para determinar si esta muerto y quieto o si aun esta en movimiento

var createsfx = load("res://Sfx/Create.ogg")
var deathsfx = load("res://Sfx/Death.ogg")
var jumpsfx = load("res://Sfx/Jump.ogg")
var splashsfx = load("res://Sfx/Splash.ogg")

func _ready():
	$PlayerSound.stream = createsfx
	$PlayerSound.play()
	snap = Vector2(0, 32)

func _physics_process(delta):
	if !is_static: 
		move(delta)
		if !alive:
			if !dead:
				if capsule_height < 35:
					$CollisionShape2D.shape.height += 1
					if $AnimatedSprite.flip_h:
						$CollisionShape2D.position.x -= 1
						if is_on_wall():
							position.x += 1
					else:
						$CollisionShape2D.position.x += 1
						if is_on_wall():
							position.x -= 1
					capsule_height+=1
				if capsule_height >= 35:
					dead = true
			if dead:
				set_collision_mask_bit(2,true)
				set_collision_layer_bit(1,false)
				set_collision_layer_bit(3,true)
				if is_on_floor():
					move.y = 0
					move.x = 0
					snap = Vector2(0,32)
					emit_signal("im_dead")
					is_static = true
	if is_static:
		if is_on_floor():
			move.y = 0
		move.y+= delta*GRAVITY
	if !Engine.is_editor_hint():
		move_and_slide_with_snap(move, snap,Vector2(0,-1))

func move(delta): #Se encarga de mover a player dentro de los niveles
	if is_on_floor(): #Setea la velocidad en Y a 0 cuando toca el suelo
		move.y = 0
		snap = Vector2(0,32)
	if alive: #Si aun sigue vivo escucha los toques de los controles 
		if Input.is_action_just_pressed("touch_left"):
			change_direction(true, -1)
		if Input.is_action_just_pressed("touch_right"):
			change_direction(false, 1)
		if Input.is_action_just_pressed("touch_stop"):
			direction = 0
		if is_on_floor(): #Si esta en el suelo puede saltar
			if Input.is_action_just_pressed("touch_jump"):
				$PlayerSound.stream = jumpsfx
				$PlayerSound.play()
				snap = Vector2.ZERO
				$AnimatedSprite.play("jump")
				move.y = -jump_speed
		if swimming:
			float_up()
		if direction == 0: #Lo anima segun su movimiento
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("walk")
	if !swimming: #Si esta en tierra, mueve al personaje normalmente
		move.x = direction * speed
		move.y += delta * GRAVITY
	if is_on_ceiling(): #Añade una fuerza en Y para que rebote contra el techo
		if alive:
			$AnimatedSprite.play("idle")
		move.y = 50

func change_direction(_state, _direction): #Cambia la dirección de movimiento y del sprite y figura de colisión
	if direction != _direction:
		direction = _direction
	if flip != _state:
		flip = _state
		$AnimatedSprite.flip_h = _state
		$CollisionShape2D.position.x = -$CollisionShape2D.position.x

func die(): #Anima la muerte del jugador, cambiando la figura de colisión y haciendola rotar y crecer para adaptarse a la forma de player
	#Evita que continúe colisionando con los pinchos
	$PlayerSound.stream = deathsfx
	$PlayerSound.play()
	set_collision_mask_bit(6, false)
	$AnimatedSprite.play("die")
	alive = false
	$CollisionShape2D.shape = capsuleshape.duplicate()
	$CollisionShape2D.position.y = 35
	$CollisionShape2D.rotate(1.5708)
	if is_on_floor():
		move.x = 0
	$AnimatedSprite.modulate = Color(0.5,0.5,1.0)

func swim(_water_top = 0): #Cambia los valores de las variables para indicar que está dentro del agua
	if alive:
		if move.y > 30:
			$PlayerSound.stream = splashsfx
			$PlayerSound.play()
		WATER_GRAVITY = 150
		water_top = _water_top
		swimming = !swimming

func float_up(): #Mueve a player cuando se encuentra dentro del agua
	move.x = direction * swim_speed
	if position.y < water_top:
		if floating:
			WATER_GRAVITY = 25
	if position.y > water_top + 25:
		if !floating:
			floating = true
		WATER_GRAVITY = -25
	move.y = WATER_GRAVITY
	if is_on_wall() && WATER_GRAVITY < 0 && position.y <= water_top+5: #Permite saltar para salir del agua si esta contra una pared
		if Input.is_action_pressed("touch_jump"):
			move.y = -jump_speed / 1.5
			floating = false
			swimming = false