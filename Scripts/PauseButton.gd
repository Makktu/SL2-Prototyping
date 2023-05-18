extends Node2D

func _on_PauseButton_pressed():
	if !$"/root/Global".game_paused:
		get_tree().paused = true
		$"/root/Global".game_paused = true
		$EnemiesToggle.visible = true
		$FrameRate.visible = true
		$MusicToggle.visible = true
	else:
		get_tree().paused = false
		$"/root/Global".game_paused = false
		$EnemiesToggle.visible = false
		$FrameRate.visible = false
		$MusicToggle.visible = false


func _on_EnemiesToggle_pressed():
	if $"/root/Global".enemies_on:
		$"/root/Global".enemies_on = false
		$EnemiesToggle.text = "enemies_OFF"
	else:
		$"/root/Global".enemies_on = true
		$EnemiesToggle.text = "enemies_ON"	


func _on_FrameRate_pressed() -> void:
	if $"/root/Global".show_framerate:
		$FrameRate.text = "frame_rate_OFF"
		$"/root/Global".show_framerate = false
	else:
		$FrameRate.text = "frame_rate_ON"
		$"/root/Global".show_framerate = true
		

func _on_MusicToggle_pressed():
	if $"/root/Global".music_toggle:
		$MusicToggle.text = "music_OFF"
		$"/root/Global".music_toggle = false
	else:
		$MusicToggle.text = "music_ON"
		$"/root/Global".music_toggle = true
	
