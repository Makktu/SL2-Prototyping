extends Node2D

var taking_damage = false

var environments = ["res://Scenes/Environment_0.tscn", "res://Scenes/Environment_1.tscn"]

var current_environment = 1

onready var the_player = "res://Scenes/Player.tscn"


func _ready():
	pass

func get_player():
	return the_player	
	
func basic():
	$Basic.play()
	
func alt():
	$Alt.play()
	
func under_threat():
	$Basic.volume_db = -20
	$Threat.play()

	

