extends Button

func _ready():
	$"/root/Global".basic()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")
