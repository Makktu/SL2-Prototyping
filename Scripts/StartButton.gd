extends Button

func _ready():
	$"../TitleMusic".play()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")
