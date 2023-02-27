extends Node2D

onready var basic_enemy = preload("res://Scenes/BasicEnemy1.tscn")
var spawned = false
var amount_spawned = 0


func _on_Area2D_body_entered(body):
	if !spawned:
		$"/root/Global".under_threat()
		spawned = true
		start_spawning()
	

func start_spawning():
	var loaded_enemy = basic_enemy.instance()
	add_child(loaded_enemy)
	if amount_spawned < 6:
		amount_spawned += 1
		$SpawnTimer.start()


func _on_SpawnTimer_timeout() -> void:
	start_spawning()
