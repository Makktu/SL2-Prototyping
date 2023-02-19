extends Camera2D

var zoom_start = 1
var new_zoom = 0.005


func _ready():
	pass
	
func change_zoom():
	for n in 80: 		
		yield(get_tree().create_timer(0.15), "timeout")	
		zoom = Vector2(zoom_start,zoom_start)
		zoom_start += new_zoom
	reverse_zoom()
	
func reverse_zoom():
	for n in 110: 		
		yield(get_tree().create_timer(0.05), "timeout")	
		zoom = Vector2(zoom_start,zoom_start)
		zoom_start -= new_zoom
	
