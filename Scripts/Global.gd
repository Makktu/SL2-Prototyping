extends Node2D

var taking_damage = false

var environments = ["res://Scenes/Environment_0.tscn", "res://Scenes/Environment_1.tscn", "res://Scenes/Environment_3.tscn"]

var current_environment = 2

onready var the_player = "res://Scenes/Player.tscn"

var enemies_chasing_player = 0
var enemies_active = false


func _ready():
	pass

func get_player():
	return the_player	
	
func basic():
	$Basic.play()
	
func alt():
	$Alt.play()
	
func under_threat():
	enemies_active = true
	$Basic.volume_db = -20
	$Threat.play()
	for n in 500:
		$Threat.volume_db += 0.15
		if $Threat.volume_db == 0:
			break
	
func _physics_process(delta):
	if enemies_chasing_player == 0 && enemies_active:
		enemies_active = false
		for n in 3000:
			$Threat.volume_db -= 0.01
			if $Threat.volume_db == -80:
				break
		$Threat.volume_db = -80
		$Threat.stop()
		$Basic.volume_db = 0


