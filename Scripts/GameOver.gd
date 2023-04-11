extends Node2D

func _on_MainMenu_pressed():
	get_tree().paused = false
	$"/root/Global".game_over = false
	get_tree().change_scene("res://Scenes/StartScreen.tscn")


