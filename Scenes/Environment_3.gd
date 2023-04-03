extends Area2D


func _ready():
	pass


func _on_Environment_3_body_entered(body):
	get_parent().get_child(0)._on_BG_body_entered(body)
