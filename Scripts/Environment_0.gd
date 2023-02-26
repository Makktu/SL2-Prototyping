extends Node2D


func _ready():
	$BG/Pillar2/AnimationPlayer.play("PillarThrob")


func _on_BG_body_entered(body):
	get_parent().get_child(0)._on_BG_body_entered(body)
