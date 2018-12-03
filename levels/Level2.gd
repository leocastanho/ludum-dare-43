extends Node2D

var before_hole_activated = false
onready var text_system = $text_system

func _ready():
	get_node("/root/MusicBG").stop() 

func restart():
	var player = global.player
	player.death(true)
	global.player_died = true
	text_system.text_count = 0
	text_system._on_NextButton_pressed()
	text_system.pop_up_show()

func _on_BeforeHole_body_entered(body):
	var player = global.player
	if not before_hole_activated and body == global.player:
		text_system.text_count = 1
		player.get_node("AnimatedSprite").play("idle")
		player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		before_hole_activated = true

func _on_NextLevel_body_entered(body):
	var player = global.player
	player.get_node("Camera2D/CameraAnim").play("FallingPit")
	player.get_node("Camera2D").limit_left = -1000
	player.get_node("Camera2D").limit_top = -1000
	player.get_node("AnimatedSprite").play("hurt")
	player.get_node("PlayerBreathing").stop()
	player.get_node("PlayerFalling").play()
	player.set_physics_process(false)
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene(global.level3)
