extends KinematicBody2D

var move_speed = 5
var energy_level = 50

var game_over = false

var thruster_speed = 500
var constant_speed = 200

var x_input_dir = 0
var y_input_dir = 0

# GLOBAL PHYSICS VALUES:
var acceleration = 1
var gravity = 0
var velocity = Vector2.ZERO
var friction = 0.0
var max_speed = 50
var speed = 0

func _ready():
	$"../PulseTimer".start()
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	var input = Vector2()

	input.x += float(Input.is_action_pressed('ui_left'))
	input.x -= float(Input.is_action_pressed('ui_right'))
	input.y += float(Input.is_action_pressed('ui_up'))
	input.y -= float(Input.is_action_pressed('ui_down'))	
	
func get_input():
	if game_over:
		return
		
	x_input_dir = 0
	y_input_dir = 0
		
	if Input.is_action_pressed("ui_left"):
		speed += constant_speed
		x_input_dir += thruster_speed
		if x_input_dir >= max_speed:
			x_input_dir = max_speed
	if Input.is_action_pressed("ui_right"):
		speed += constant_speed
		x_input_dir -= thruster_speed
		if x_input_dir >= max_speed:
			x_input_dir = max_speed
	if Input.is_action_pressed("ui_up"):
		speed += constant_speed
		y_input_dir += thruster_speed
		if y_input_dir >= max_speed:
			y_input_dir = max_speed
	if Input.is_action_pressed("ui_down"):
		speed += constant_speed
		y_input_dir -= thruster_speed
		if y_input_dir >= max_speed:
			y_input_dir = max_speed
			
	if speed > max_speed:
		speed = max_speed
		
	if x_input_dir != 0 or y_input_dir != 0:
		# accelerate when there's input
		if x_input_dir != 0:
			velocity.x = move_toward(velocity.x, x_input_dir * speed, acceleration)
		if y_input_dir != 0:
			velocity.y = move_toward(velocity.y, y_input_dir * speed, acceleration)			
	else:
		# slow down when there's no input (not applicable in zero-g)
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.y = move_toward(velocity.y, 0, friction)
		
	velocity.normalized()
		
	if Input.is_action_pressed("ui_select"):
		if energy_level >= 20:
			print("pulse fired!")
			energy_level -= 20
		else:
			print("pulse energy too low!")


func _on_PulseTimer_timeout() -> void:
	if energy_level <= 98:
		energy_level += 2
	print(energy_level)
