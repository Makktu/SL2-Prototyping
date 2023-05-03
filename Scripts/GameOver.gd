extends Node2D

func game_over():
	get_tree().paused = true
	$"/root/Global".taking_damage = false
	$"/root/Global".enemies_gone()
	$CanvasLayer.visible = true
	

func _on_MainMenu_pressed():
	get_tree().paused = false
	$CanvasLayer.visible = false
	get_tree().change_scene("res://Scenes/StartScreen.tscn")

func _on_Restart_pressed():
	get_tree().paused = false
	$CanvasLayer.visible = false
	get_tree().change_scene("res://Scenes/World.tscn")
