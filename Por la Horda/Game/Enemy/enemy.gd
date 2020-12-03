extends KinematicBody2D

#Controlador de los enemigos de los niveles

const GRAVITY = 900
var move = Vector2.ZERO
const speed = 200
var alive

func _ready():
	alive = true
	move = Vector2(speed,0)

func _physics_process(delta): #Controla el movimiento del cuerpo
	if alive:
		if !is_on_floor():
			move.y += delta*GRAVITY
		if !$RayCast2D.is_colliding() || is_on_wall(): #cuando el rayo deja de colisionar o está contra una pared, voltea al enemigo
			flip()
		move_and_slide(move,Vector2(0,-1))
	

func _on_Area2D_body_entered(body): #Chequa colisión contra player y ejecuta las acciones de su muerte
	if alive:
		set_collision_layer_bit(2,false)
		set_collision_mask_bit(3,false)
		set_collision_layer_bit(7,false)
		body.die()
		alive = false
	$AnimationPlayer.play("Die")

func flip(): #Cambia todos los valores que afectan al movimiento y visualización para que se dirija hacia el lado contrario.
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
	$RayCast2D.cast_to.x = -$RayCast2D.cast_to.x
	move.x = -move.x

func _on_AnimationPlayer_animation_finished(anim_name): #Elimina el enemigo cuando termina la animación de la muerte.
	queue_free()
