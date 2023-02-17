extends Node2D


#func _ready():
#	$BG_Music.play()
	

func set_alarm():
	$BG_Music.stop()
	$AlarmSound/AlarmSignal.play()


func _on_AlarmTrigger_body_entered(body):
	print("Entered?")
	set_alarm()


func _on_Area2D_body_entered(body):
	print("crash!")
