extends Node2D

func _ready():
	var player = global.player
	player.set_physics_process(false)
	get_node("/root/MusicBG").volume_db = -8
	get_node("/root/MusicBG").play()