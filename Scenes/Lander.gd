extends Sprite

var move_speed = 5
var energy_level = 50

func _ready():
	$"../PulseTimer".start()
	
func _physics_process(delta):
	get_input()
	
func get_input():
	if Input.is_action_pressed("ui_left"):
		position.x -= move_speed
	if Input.is_action_pressed("ui_right"):
		position.x += move_speed
	if Input.is_action_pressed("ui_up"):
		position.y -= move_speed
	if Input.is_action_pressed("ui_down"):
		position.y += move_speed
		
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
