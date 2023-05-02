extends Node2D

func _ready():
	world_controller()
	
func world_controller():
	#load the current environment into the scene tree
	var this_environment = load($"/root/Global".environments[$"/root/Global".current_environment])
	var loaded_environment = this_environment.instance()
	add_child(loaded_environment)
