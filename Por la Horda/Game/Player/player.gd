tool
extends KinematicBody2D

signal im_dead

const GRAVITY = 900
var WATER_GRAVITY = 25
const speed = 200.0
const jump_speed = 600
var move = Vector2.ZERO
export var alive = true
var dead = false
var direction:int
var flying = false
var swimming = false
var water_top
var floating = false
var flip = false
var capsuleshape = load("res://Game/Player/capsule_shape_2d.tres")
var capsule_height = 0
var snap = Vector2(0,32)

var createsfx = load("res://Sfx/Create.ogg")
var deathsfx = load("res://Sfx/Death.ogg")
var jumpsfx = load("res://Sfx/Jump.ogg")

func _ready():
	$PlayerSound.stream = createsfx
	$PlayerSound.play()
	snap = Vector2(0, 32)

func _physics_process(delta):
	if alive:
		move()
		if Input.is_action_just_pressed("touch_left"):
			direction = -1
			if !flip:
				flip = true
				$AnimatedSprite.flip_h = true
				$CollisionShape2D.scale.x = -$CollisionShape2D.scale.x
		if Input.is_action_just_pressed("touch_right"):
			direction = 1
			if flip:
				flip = false
				$AnimatedSprite.flip_h = false
				$CollisionShape2D.scale.x = -$CollisionShape2D.scale.x
		if Input.is_action_pressed("touch_stop"):
			direction = 0
		if !swimming:
			move.y += delta * GRAVITY
			if is_on_floor():
				flying = false
				if direction == 0:
					$AnimatedSprite.play("idle")
				else:
					$AnimatedSprite.play("walk")
				move.y = 0
				if Input.is_action_pressed("touch_jump"):
					snap = Vector2.ZERO
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
		if swimming:
			if position.y < water_top:
				if floating:
					WATER_GRAVITY = 25
			if position.y > water_top + 25:
				if !floating:
					floating = true
				WATER_GRAVITY = -25
			move.x = direction * speed/3
			if !flying:
				move.y = WATER_GRAVITY
			if is_on_wall() && WATER_GRAVITY < 0 && position.y <= water_top+5:
				if Input.is_action_pressed("touch_jump"):
					move.y = -jump_speed / 2
					floating = false
					flying = true
		if !Engine.is_editor_hint():
			move_and_slide_with_snap(move, snap,Vector2(0,-1))
	if !alive:
		if !is_on_floor():
			move.y += delta * GRAVITY
			if !Engine.is_editor_hint():
				move_and_slide_with_snap(move, Vector2(0,-1))
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
			emit_signal("im_dead")
			set_physics_process(false)

func move():
	pass

func die():
	set_collision_mask_bit(6, false)
	$AnimatedSprite.play("die")
	alive = false
	$CollisionShape2D.shape = capsuleshape.duplicate()
	$CollisionShape2D.position.y = 35
	$CollisionShape2D.rotate(1.5708)
	move.x = 0

func swim(_water_top = 0):
	if alive:
		if flying:
			flying = false
		WATER_GRAVITY = 150
		water_top = _water_top
		swimming = !swimming