extends Node2D

onready var basic_enemy = preload("res://Scenes/BasicEnemy1.tscn")
var spawned = false

func _ready():
	pass


func _on_Area2D_body_entered(body):
	print("Triggered")
	if !spawned:
		start_spawning()
	
func start_spawning():
	spawned = true
	var loaded_enemy = basic_enemy.instance()
	add_child(loaded_enemy)
