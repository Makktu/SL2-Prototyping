extends Area2D

func _on_EnergyPickup_body_entered(body):
	if body.name == "Player":
		print("pickedup!")
		$"/root/Global".player_energy += 25
		$"/root/Global".taking_damage = true
		$AudioStreamPlayer.play()
		self.visible = false
		# add slow fill up of player energy meter


func _on_AudioStreamPlayer_finished():
	queue_free()
