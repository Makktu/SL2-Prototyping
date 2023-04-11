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
var platform = OS.get_name()

##########################
# PLAYER STARTING VALUES #
var starting_energy = 50
var player_energy = starting_energy
##########################

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
	if enemies_chasing_player == 0 && enemies_active:
		enemies_gone()
	if player_energy <= 0:
		player_energy = starting_energy
		$GameOver.game_over()
		
		
func enemies_gone():
	enemies_active = false
	fade_out($Threat)
	$Basic.play()
	fade_in($Basic)

		
func fade_out(stream_player):
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	
	
func fade_in(stream_player):
	tween_in.interpolate_property(stream_player, "volume_db", -80, 0, transition_duration, transition_type, Tween.EASE_OUT, 0)
	tween_in.start()
	
	
func _on_Tween_tween_completed(object, key):
	object.stop()
	object.volume_db = 0

	
func undo_game_over():
	$GameOver/CanvasLayer.visible = false
#	get_tree().paused = false
