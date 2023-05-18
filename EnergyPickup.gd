extends Area2D

func _on_EnergyPickup_body_entered(body):
	if body.name == "Player":
		fill_energy_bar()
		$"/root/Global".player_energizing = false
		$"/root/Global".player_energizing_has_stopped = true
		
		
func fill_energy_bar():
	$"/root/Global".player_energizing = true
	$AudioStreamPlayer.play()
	self.visible = false
	for n in 50:
		if $"/root/Global".player_energy >= 100:
			return
		$"/root/Global".taking_damage = true
		$"/root/Global".player_energy += 1
		yield(get_tree().create_timer(0.2), "timeout")
		$"/root/Global".taking_damage = false

		


func _on_AudioStreamPlayer_finished():
	queue_free()
