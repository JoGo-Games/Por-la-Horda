extends KinematicBody2D

const GRAVITY = 900
const speed = 200.0
const jump_speed = 600
var move = Vector2.ZERO
var direction:int
var flying = false
var flip = false;

func _physics_process(delta):
	move.y += delta * GRAVITY
	if Input.is_action_just_pressed("ui_left"):
		direction = -1
		if !flip:
			flip = true
			$AnimatedSprite.flip_h = true
			$CollisionShape2D.position.x += 30
	if Input.is_action_just_pressed("ui_right"):
		direction = 1
		if flip:
			flip = false
			$AnimatedSprite.flip_h = false
			$CollisionShape2D.position.x -= 30
	if Input.is_action_pressed("ui_down"):
		direction = 0
		$AnimatedSprite.play("idle")
	if Input.is_action_just_pressed("ui_end"):
		$AnimatedSprite.play("die")
	
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
	if is_on_wall():
		direction=0
	move.x = direction * speed
	move_and_slide(move, Vector2(0,-1))