extends Sprite

var move_speed = 5
var energy_level = 50

func _ready():
	pass
	
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
		print("pulse fired!")
