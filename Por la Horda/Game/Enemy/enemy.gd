extends KinematicBody2D

const GRAVITY = 900
var move = Vector2.ZERO
const speed = 200

signal _kill

func _ready():
	move = Vector2(speed,0)

func _physics_process(delta):
	if !is_on_floor():
		move.y += delta*GRAVITY
	if !$RayCast2D.is_colliding() || is_on_wall():
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$RayCast2D.cast_to.x = -$RayCast2D.cast_to.x
		move.x = -move.x
	move_and_slide(move,Vector2(0,-1))
	

func _on_Area2D_body_entered(body):
	body._die()
