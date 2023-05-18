extends Node2D

func _ready():
	if $"/root/Global".music_toggle:
		$"/root/Global".alt()
