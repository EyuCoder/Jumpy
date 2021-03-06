extends KinematicBody2D

var motion = Vector2(0, 0)

const SPEED = 500
const GRAVITY = 200
const UP = Vector2(0, -1)
const JUMP_SPEED = 2800

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)

func apply_gravity():
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY

func jump():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		motion.y -= JUMP_SPEED

func move():
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = SPEED
	else:
		motion.x = 0
	move_and_slide(motion)

func animate():
	emit_signal("animate", motion)
