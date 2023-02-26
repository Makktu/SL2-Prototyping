extends Node2D

var taking_damage = false

var environments = ["res://Scenes/Environment_0.tscn"]

var current_environment = 0

onready var the_player = "res://Scenes/Player.tscn"


func _ready():
	pass

func get_player():
	return the_player	

	

