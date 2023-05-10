extends Label


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if $"/root/Global".show_framerate:
		text = "FPS " + String(Engine.get_frames_per_second())
	else:
		text = ""
