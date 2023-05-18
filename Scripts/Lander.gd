extends KinematicBody2D

# initialise swipe control variables
onready var Swipe = $PlayerCamera/SwipeScreenButton
var swipe_up = false
var swipe_down = false
var swipe_left = false
var swipe_right = false

var swipe_down_released = false
var swipe_up_released = false
var swipe_left_released = false
var swipe_right_released = false

var double_tap = false

var move_speed = 2
var energy_level = 50
var game_over = false
var thruster_speed = 300
var constant_speed = 100
var x_input_dir = 0
var y_input_dir = 0
# _____GLOBAL PHYSICS VALUES:
var acceleration = 1 # Dictates the handling of the Lander - the higher the value, the lighter the ship
var gravity = 29 # Will always be 0 in zero-g; can be dynamically changed for 'gravity well' zones
var velocity = Vector2.ZERO
var friction = 0.0 # always zero in hard vacuum; can also be dynamically changed in atmosphere, asteroid fields and the like
var max_speed = 50
var speed = 0

var thruster_plume_length = 0
var pulse_fired = false

var pressed_down = 0
var middle_on = false
# _________________________

func _ready():
	$EnergyBar.value = $"/root/Global".player_energy

func camera_shake(shake_amount):
	$PlayerCamera.set_offset(Vector2( \
		rand_range(-3.0, 3.0) * shake_amount, \
		rand_range(-3.0, 3.0) * shake_amount \
	))
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	var input = Vector2()

	input.x += float(Input.is_action_pressed('ui_left'))
	input.x -= float(Input.is_action_pressed('ui_right'))
	input.y += float(Input.is_action_pressed('ui_up'))
	input.y -= float(Input.is_action_pressed('ui_down'))	
	
	if $"/root/Global".taking_damage:
		$EnergyBar.value = $"/root/Global".player_energy
		$"/root/Global".taking_damage = false
		
	if $"/root/Global".player_energizing:
		$Sprite/EnergizeAnimation.play("energize")
		
	if $"/root/Global".player_energizing_has_stopped:
		$"/root/Global".player_energizing = false
		$Sprite/EnergizeAnimation.stop()
		$"/root/Global".player_energizing_has_stopped = false
		
	
func get_input():
	if game_over:
		return
		
	x_input_dir = 0
	y_input_dir = 0

	# DOUBLE-TAP ENERGY PULSE________________
	if double_tap or Input.is_action_pressed("ui_select"):
		if $"/root/Global".pulser_fired:
			return
		$PulserSound.play()
		$Sprite/EnergyPulse.frame = 0
		$Sprite/EnergyPulse.visible = true
		$Sprite/EnergyPulse.play("energy_pulse");
		$"/root/Global".pulser_fired = true
		$Sprite/EnergyPulse/CooldownTimer.start()
		if double_tap:
			double_tap = false

	# LEFT____________________________________
	if Input.is_action_pressed("ui_left") || swipe_right:
		$Sprite/LeftThruster.visible = true
		if !$MainThruster.playing:
			$MainThruster.play()
		if !middle_on:
			$Sprite/LeftThruster.playing = true
		if pressed_down > 5 and !middle_on:
			$Sprite/LeftThruster.stop()
			$Sprite/LeftThruster.play("top_middle")
			middle_on = true
		speed += constant_speed
		x_input_dir += thruster_speed
		if x_input_dir >= max_speed:
			x_input_dir = max_speed
		pressed_down += 0.10
		
	if Input.is_action_just_released("ui_left") || swipe_right_released:
		$MainThruster.stop()
		$Sprite/LeftThruster.visible = false
		$Sprite/LeftThruster.playing = false
		$Sprite/LeftThruster.set_frame(0)
		pressed_down = 0
		middle_on = false
		swipe_right_released = false
	
	# RIGHT____________________________________
	if Input.is_action_pressed("ui_right") || swipe_left:
		$Sprite/RightThruster.visible = true
		if !$MainThruster.playing:
			$MainThruster.play()
		if !middle_on:
			$Sprite/RightThruster.playing = true
		if pressed_down > 5 and !middle_on:
			$Sprite/RightThruster.stop()
			$Sprite/RightThruster.play("top_middle")
			middle_on = true
		speed += constant_speed
		x_input_dir -= thruster_speed
		if x_input_dir >= max_speed:
			x_input_dir = max_speed
		pressed_down += 0.10
		
	if Input.is_action_just_released("ui_right") || swipe_left_released:
		$MainThruster.stop()
		$Sprite/RightThruster.visible = false
		$Sprite/RightThruster.playing = false
		$Sprite/RightThruster.set_frame(0)
		pressed_down = 0
		middle_on = false
		swipe_left_released = false
			
	# UP____________________________________
	if Input.is_action_pressed("ui_up") || swipe_down:
		$Sprite/TopThruster.visible = true
		if !$MainThruster.playing:
			$MainThruster.play()
		if !middle_on:
			$Sprite/TopThruster.playing = true
		if pressed_down > 5 and !middle_on:
			$Sprite/TopThruster.stop()
			$Sprite/TopThruster.play("top_middle")
			middle_on = true		
		speed += constant_speed
		y_input_dir += thruster_speed
		if y_input_dir >= max_speed:
			y_input_dir = max_speed
		pressed_down += 0.10
			
	if Input.is_action_just_released("ui_up") || swipe_down_released:
		$MainThruster.stop()
		$Sprite/TopThruster.visible = false
		$Sprite/TopThruster.playing = false
		$Sprite/TopThruster.set_frame(0)
		pressed_down = 0
		middle_on = false
		swipe_down_released = false
		
	# DOWN_____________________________________
	if Input.is_action_pressed("ui_down") || swipe_up:
		$MainThruster.pitch_scale = 0.6
		$MainThruster.volume_db = 16
		$Sprite/MainThruster.visible = true
		if !$MainThruster.playing:
			$MainThruster.play()
		if !middle_on:
			$Sprite/MainThruster.play("new_main_thruster")
		if pressed_down > 5 and !middle_on:
			$Sprite/MainThruster.stop()
			$Sprite/MainThruster.play("middle_main")
			middle_on = true
		speed += constant_speed
		y_input_dir -= thruster_speed
		if y_input_dir >= max_speed:
			y_input_dir = max_speed
		pressed_down += 0.10
			
	if Input.is_action_just_released("ui_down") || swipe_up_released:
		$MainThruster.pitch_scale = 1
		$MainThruster.volume_db = 0
		$MainThruster.stop()
		$Sprite/MainThruster.visible = false
		$Sprite/MainThruster.stop()
		$Sprite/MainThruster.set_frame(0)
		pressed_down = 0
		middle_on = false
		swipe_up_released = false
			
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
		

func _on_PulseTimer_timeout() -> void:
	if energy_level <= 98:
		energy_level += 2

func increase_plume_length():
	if $Sprite/Thruster1.scale.y > 5:
		return
	$Sprite/Thruster1.scale.y += 0.01
	
func _input(event):
	if event is InputEventScreenDrag:
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.UP:
			swipe_down = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.DOWN:
			swipe_up = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.LEFT:
			swipe_right = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.RIGHT:
			swipe_left = true
			
	if Swipe.on_area == false && swipe_down == true:
		swipe_down_released = true
		swipe_down = false
	if Swipe.on_area == false && swipe_up == true:
		swipe_up_released = true
		swipe_up = false
	if Swipe.on_area == false && swipe_left == true:
		swipe_left_released = true
		swipe_left = false
	if Swipe.on_area == false && swipe_right == true:
		swipe_right_released = true
		swipe_right = false	


func _on_BG_body_entered(body):
	if velocity.x:
		velocity.x = -velocity.x / 2
	if velocity.y:
		velocity.y = -velocity.y / 2
	$"/root/Global".taking_damage = true
	$"/root/Global".player_energy -= 10
	$Collision.play()


func _on_EnergyPulse_animation_finished():
	$Sprite/EnergyPulse.visible = false;


func _on_SwipeScreenButton_double_tap():
	if !double_tap:
		double_tap = true


func _on_CooldownTimer_timeout():
	$"/root/Global".pulser_fired = false

