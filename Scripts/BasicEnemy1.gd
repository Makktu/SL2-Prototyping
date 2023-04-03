extends KinematicBody2D

var speed = 80

var target_position

onready var the_player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("enemy_throb")
	$"/root/Global".enemies_chasing_player += 1
	_physics_process(true)
	
func _physics_process(delta):
	target_position = (the_player.global_position - global_position).normalized()
	move_and_slide(target_position * speed)
	
	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$"/root/Global".taking_damage = true
		$"/root/Global".enemies_chasing_player -= 1
		queue_free()
		
