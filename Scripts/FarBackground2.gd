extends ParallaxLayer


func _ready():
	change_colours()
	
func change_colours():
	$AnimationPlayer.play("throbbing_stars")
