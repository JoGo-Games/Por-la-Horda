extends KinematicBody2D

const GRAVITY = 900
var move = Vector2.ZERO
const speed = 200
var alive

func _ready():
	alive = true
	move = Vector2(speed,0)

func _physics_process(delta):
	if alive:
		if !is_on_floor():
			move.y += delta*GRAVITY
		if !$RayCast2D.is_colliding() || is_on_wall():
			flip()
		move_and_slide(move,Vector2(0,-1))
	

func _on_Area2D_body_entered(body):
	if alive:
		set_collision_layer_bit(2,false)
		set_collision_mask_bit(3,false)
		set_collision_layer_bit(7,false)
		body.die()
		alive = false
	$AnimationPlayer.play("Die")

func flip():
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
	$RayCast2D.cast_to.x = -$RayCast2D.cast_to.x
	move.x = -move.x

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
