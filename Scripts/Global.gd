extends Node2D

onready var tween_out = get_node("Tween")
onready var tween_in = get_node("Tween_In")
var transition_duration = 5.00
var transition_type = 1
var taking_damage = false
var environments = ["res://Scenes/Environment_0.tscn", "res://Scenes/Environment_1.tscn", "res://Scenes/Environment_3.tscn"]
var current_environment = 2
onready var the_player = "res://Scenes/Player.tscn"
var enemies_chasing_player = 0
var enemies_active = false
#var current_music_position
var platform = OS.get_name()

var player_energy = 100
var game_over = false

func _ready():
	print(platform)

func get_player():
	return the_player	
	
func basic():
	$Basic.play()
	
func alt():
	$Alt.play()
	
func under_threat():
	enemies_active = true
	fade_out($Basic)
	$Threat.play()
	fade_in($Threat)

	
func _physics_process(delta):
	if game_over:
		print("GAME OVER")
#		get_tree().paused = true	
	if enemies_chasing_player == 0 && enemies_active:
		enemies_active = false
		fade_out($Threat)
		$Basic.play()
		fade_in($Basic)
	if player_energy <= 0:
		game_over = true
		
		
func fade_out(stream_player):
#	current_music_position = $Basic.get_playback_position()
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	
	
func fade_in(stream_player):
	tween_in.interpolate_property(stream_player, "volume_db", -80, 0, transition_duration, transition_type, Tween.EASE_OUT, 0)
	tween_in.start()
	
	
func _on_Tween_tween_completed(object, key):
	object.stop()
	object.volume_db = 0


#func _on_Tween_In_tween_completed(object, key):
#	object.stop()
#	object.volume_db = -80
