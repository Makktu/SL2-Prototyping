extends Node2D

func game_over():
	$"/root/Global".game_over = false
	get_tree().paused = true
	$CanvasLayer.visible = true
	

func _on_MainMenu_pressed():
	get_tree().paused = false
	$CanvasLayer.visible = false
	get_tree().change_scene("res://Scenes/StartScreen.tscn")


