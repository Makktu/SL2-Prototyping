extends Node2D

var loaded_environment
var this_environment

func _ready():
	world_controller()
	
func _physics_process(delta):
	if $"/root/Global".level_changed:
		remove_child(loaded_environment)
		$"/root/Global".level_changed = false
		$Player.position.x = 0
		$Player.position.y = 0
		world_controller()
	
func world_controller():
	#load the current environment into the scene tree
	this_environment = load($"/root/Global".environments[$"/root/Global".current_environment])
	loaded_environment = this_environment.instance()
	add_child(loaded_environment)
