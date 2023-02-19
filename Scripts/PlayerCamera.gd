extends Camera2D

var zoom_start = 1
var new_zoom = 0.001

func _ready():
	pass
	
	
func change_zoom():
	for n in 80: 		
		yield(get_tree().create_timer(1), "timeout")	
		zoom = Vector2(zoom_start,zoom_start)
		zoom_start += new_zoom
	reverse_zoom()
	
	
func reverse_zoom():
	for n in 400: 		
		yield(get_tree().create_timer(0.05), "timeout")	
		zoom = Vector2(zoom_start,zoom_start)
		zoom_start -= new_zoom
		

func _on_Timer_timeout():
	change_zoom()
	
func _process(delta):
	if $"/root/Global".taking_damage:
		$"/root/Global".taking_damage = false
		flash_damage()
		
		
func flash_damage():
	$TakeDamage.visible = true
	yield(get_tree().create_timer(0.08), "timeout")
	$TakeDamage.visible = false
