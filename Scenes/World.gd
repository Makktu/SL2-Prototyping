extends Node2D


func _ready():
	$AudioStreamPlayer.play()
	

func set_alarm():
	$AudioStreamPlayer.stop()
	$AlarmSound/AlarmSignal.play()


func _on_AlarmTrigger_body_entered(body):
	print("Entered?")
	set_alarm()
