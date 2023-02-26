extends KinematicBody2D

var speed = 200
onready var the_player = $"/root/Player"



func _ready():
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("enemy_throb")
	print(the_player)
	_physics_process(true)
	
func _physics_process(delta):
	var direction = (the_player.position - position).normalized()
	move_and_slide(direction * speed)
	
	
