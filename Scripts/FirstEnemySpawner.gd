extends Node2D

onready var basic_enemy = preload("res://Scenes/BasicEnemy1.tscn")
var already_triggered = false
var amount_spawned = 0


func _on_Area2D_body_entered(body):
	if already_triggered == true:
		return
	$"/root/Global".under_threat()
	already_triggered = true
	start_spawning()
	

func start_spawning():
	if amount_spawned >= 25:
		return
	amount_spawned += 1
	var loaded_enemy = basic_enemy.instance()
	add_child(loaded_enemy)
	$SpawnTimer.start()


func _on_SpawnTimer_timeout() -> void:
	start_spawning()
