extends KinematicBody2D

var speed = 80

var target_position

onready var the_player = get_tree().get_nodes_in_group("player")[0]


func _ready():
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("enemy_throb")
	_physics_process(true)

	
func _physics_process(delta):
	target_position = (the_player.global_position - global_position).normalized()
	move_and_slide(target_position * speed)
	
	
