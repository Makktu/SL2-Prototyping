extends KinematicBody2D

var move_speed = 5
var energy_level = 50
var game_over = false
var thruster_speed = 500
var constant_speed = 200
var x_input_dir = 0
var y_input_dir = 0
# _____GLOBAL PHYSICS VALUES:
var acceleration = 1.25 # Dictates the handling of the Lander - the higher the value, the lighter the ship
var gravity = 0 # Will always be 0 in zero-g; can be dynamically changed for 'gravity well' zones
var velocity = Vector2.ZERO
var friction = 0.0 # always zero in hard vacuum; can also be dynamically changed in atmosphere, asteroid fields and the like
var max_speed = 50
var speed = 0

var thruster_plume_length = 0
var pulse_fired = false

var pressed_down = 0
var middle_on = false
# _________________________

#func _ready():
#	$"../PulseTimer".start()
	
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
	
	if Input.is_action_pressed("ui_select"):
		if !pulse_fired:
			$PulserSound.play()
			pulse_fired = true
			print("PULSE FIRED")		
		
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
			
	# UP____________________________________
	if Input.is_action_pressed("ui_up"):
		$Sprite/TopThruster.visible = true
		$Sprite/TopThruster.playing = true
		speed += constant_speed
		y_input_dir += thruster_speed
		if y_input_dir >= max_speed:
			y_input_dir = max_speed
			
	if Input.is_action_just_released("ui_up"):
		$Sprite/TopThruster.visible = false
		$Sprite/TopThruster.playing = false
		$Sprite/TopThruster.set_frame(0)
		
	# DOWN_____________________________________
	if Input.is_action_pressed("ui_down"):

		$Sprite/MainThruster.visible = true
		$Sprite/MainThruster.play("new_main_thruster")
		if pressed_down > 3 and !middle_on:
			$Sprite/MainThruster.stop()
			$Sprite/MainThruster.play("middle_main")
			middle_on = true

#		increase_plume_length()
#		$MainThruster.play()
		speed += constant_speed
		y_input_dir -= thruster_speed
		if y_input_dir >= max_speed:
			y_input_dir = max_speed
		pressed_down += 0.10
			
	if Input.is_action_just_released("ui_down"):
		$Sprite/MainThruster.visible = false
		$Sprite/MainThruster.stop()
		$Sprite/MainThruster.set_frame(0)
		pressed_down = 0
		middle_on = false
#		increase_plume_length()
#		thruster_plume_length = 0
#		$MainThruster.stop()
			
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
	
func increase_plume_length():
	if $Sprite/Thruster1.scale.y > 5:
		return
	$Sprite/Thruster1.scale.y += 0.01
