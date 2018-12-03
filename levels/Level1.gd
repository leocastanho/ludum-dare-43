extends Node2D

var area_two_activated = false
var area_three_activated = false
var area_four_activated = false
onready var text_system = $text_system

func _ready():
	get_node("/root/MusicBG").stop()

func restart():
	global.player.death(true)
	global.player_died = true
	text_system.text_count = 0
	text_system._on_NextButton_pressed()
	text_system.pop_up_show()

func _on_Area2_body_entered(body):
	if not area_two_activated and body == global.player:
		text_system.text_count = 1
		global.player.get_node("AnimatedSprite").play("idle")
		global.player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		area_two_activated = true
		global.payer_spawn_position = $PlayerSpawnPosition2.position

func _on_Area3_body_entered(body):
	if not area_three_activated and body == global.player:
		text_system.text_count = 2
		global.player.get_node("AnimatedSprite").play("idle")
		global.player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		area_three_activated = true
		global.payer_spawn_position = $PlayerSpawnPosition3.position

func _on_NextLevel_body_entered(body):
	get_tree().change_scene(global.level2)
