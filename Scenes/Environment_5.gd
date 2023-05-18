extends Area2D

func _on_Environment_5_body_entered(body):
	get_parent().get_child(0)._on_BG_body_entered(body)
