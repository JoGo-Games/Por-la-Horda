tool
extends KinematicBody2D

signal im_dead

const GRAVITY = 800
var WATER_GRAVITY = 25
const speed = 200.0
const swim_speed = 100.0
const jump_speed = 600
var move = Vector2.ZERO
export var alive = true
var dead = false
var direction:int
var swimming = false
var water_top
var floating = false
var flip = false
var capsuleshape = load("res://Game/Player/capsule_shape_2d.tres")
var capsule_height = 0
var snap = Vector2(0,32)
var is_static = false

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

func move(delta):
	if is_on_floor():
		move.y = 0
		snap = Vector2(0,32)
	if alive:
		if Input.is_action_just_pressed("touch_left"):
			change_direction(true, -1)
		if Input.is_action_just_pressed("touch_right"):
			change_direction(false, 1)
		if Input.is_action_just_pressed("touch_stop"):
			direction = 0
		if is_on_floor():
			if Input.is_action_just_pressed("touch_jump"):
				$PlayerSound.stream = jumpsfx
				$PlayerSound.play()
				snap = Vector2.ZERO
				$AnimatedSprite.play("jump")
				move.y = -jump_speed
		if swimming:
			float_up()
		if direction == 0:
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("walk")
	if !swimming:
		move.x = direction * speed
		move.y += delta * GRAVITY
	if is_on_ceiling():
		if alive:
			$AnimatedSprite.play("idle")
		move.y = 50

func change_direction(_state, _direction):
	if direction != _direction:
		direction = _direction
	if flip != _state:
		flip = _state
		$AnimatedSprite.flip_h = _state
		$CollisionShape2D.position.x = -$CollisionShape2D.position.x

func die():
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

func swim(_water_top = 0):
	if alive:
		if move.y > 30:
			$PlayerSound.stream = splashsfx
			$PlayerSound.play()
		WATER_GRAVITY = 150
		water_top = _water_top
		swimming = !swimming

func float_up():
	move.x = direction * swim_speed
	if position.y < water_top:
		if floating:
			WATER_GRAVITY = 25
	if position.y > water_top + 25:
		if !floating:
			floating = true
		WATER_GRAVITY = -25
	move.y = WATER_GRAVITY
	if is_on_wall() && WATER_GRAVITY < 0 && position.y <= water_top+5:
		if Input.is_action_pressed("touch_jump"):
			move.y = -jump_speed / 1.5
			floating = false
			swimming = false