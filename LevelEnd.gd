extends Area2D

func _on_LevelEnd_body_entered(body):
	if body.name == "Player":
		$"/root/Global".current_environment += 1
		$"/root/Global".level_changed = true
