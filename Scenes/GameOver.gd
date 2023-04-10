extends Node2D


func _ready():
	pass


func _on_MainMenu_pressed():
	$"/root/Global".game_over = false
	get_tree().change_scene("res://Scenes/StartScreen.tscn")
