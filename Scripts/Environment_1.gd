extends Node2D


func _ready():
	$"/root/Global".basic()


func _on_Area2D_body_entered(body):
	get_parent().get_child(0)._on_BG_body_entered(body)


func _on_Environment_1_body_entered(body):
	get_parent().get_child(0)._on_BG_body_entered(body)
