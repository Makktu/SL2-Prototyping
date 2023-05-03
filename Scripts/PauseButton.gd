extends Node2D

func _on_PauseButton_pressed():
	if !$"/root/Global".game_paused:
		get_tree().paused = true
		$"/root/Global".game_paused = true
	else:
		get_tree().paused = false
		$"/root/Global".game_paused = false
