extends KinematicBody2D

signal im_dead

const GRAVITY = 900
const speed = 200.0
const jump_speed = 600
var move = Vector2.ZERO
export var alive = true
var dead = false
var direction:int
var flying = false
var flip = false
var capsuleshape = load("res://Game/Player/capsule_shape_2d.tres")
var capsule_height = 0

func _physics_process(delta):
	if alive:
		move.y += delta * GRAVITY
		if Input.is_action_just_pressed("ui_left"):
			direction = -1
			if !flip:
				flip = true
				$AnimatedSprite.flip_h = true
				$CollisionShape2D.position.x += 10
		if Input.is_action_just_pressed("ui_right"):
			direction = 1
			if flip:
				flip = false
				$AnimatedSprite.flip_h = false
				$CollisionShape2D.position.x -= 10
		if Input.is_action_pressed("ui_down"):
			direction = 0
			$AnimatedSprite.play("idle")
		if is_on_floor():
			flying = false
			if direction == 0:
				$AnimatedSprite.play("idle")
			else:
				$AnimatedSprite.play("walk")
			move.y = 0
			if Input.is_action_pressed("ui_up"):
				$AnimatedSprite.play("jump")
				move.y = -jump_speed
				flying = true
		if is_on_ceiling():
			$AnimatedSprite.play("idle")
			move.y =100
		if Input.is_action_just_pressed("ui_end"):
			$AnimatedSprite.play("die")
			alive = false
			$CollisionShape2D.shape = capsuleshape
			$CollisionShape2D.position.y = 35
			$CollisionShape2D.rotate(1.5708)
		move.x = direction * speed
		move_and_slide(move, Vector2(0,-1))
	if !alive:
		if !is_on_floor():
			move.y += delta * GRAVITY
			move_and_slide(move, Vector2(0,-1))
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
			emit_signal("im_dead")


func _die():
	$AnimatedSprite.play("die")
	alive = false
	$CollisionShape2D.shape = capsuleshape
	$CollisionShape2D.position.y = 35
	$CollisionShape2D.rotate(1.5708)
	move.x = 0