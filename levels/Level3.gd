extends Node2D

var area_two_activated = false
var area_three_activated = false
var area_four_activated = false
onready var text_system = $text_system

func _ready():
	var player = global.player
	player.get_node("Camera2D/CameraAnim").play("HittingGround")
	player.get_node("Camera2D").limit_left = -1000
	player.get_node("Camera2D").limit_top = -1000
	player.get_node("AnimatedSprite").play("hurt")
	player.get_node("PlayerFalling").play()
	player.set_physics_process(false)
	yield(player.get_node("Camera2D/CameraAnim"), "animation_finished")
	player.get_node("AnimatedSprite").play("idle")
	player.get_node("Camera2D").limit_left = 0
	player.get_node("Camera2D").limit_top = 0
	player.get_node("PlayerFalling").stream = global.hitting_ground
	player.get_node("PlayerFalling").play()

func restart():
	var player = global.player
	player.death(true)
	global.player_died = true
	text_system.text_count = 0
	text_system._on_NextButton_pressed()
	text_system.pop_up_show()

func _on_Area2_body_entered(body):
	var player = global.player
	if not area_two_activated and body == global.player:
		text_system.text_count = 4
		player.get_node("AnimatedSprite").play("idle")
		player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		area_two_activated = true
		global.payer_spawn_position = $PlayerSpawnPosition2.position

func _on_Area3_body_entered(body):
	var player = global.player
	if not area_three_activated and body == global.player:
		text_system.text_count = 2
		player.get_node("AnimatedSprite").play("idle")
		player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		area_three_activated = true
		global.payer_spawn_position = $PlayerSpawnPosition3.position

func _on_NextLevel_body_entered(body):
	if body == global.player:
		get_tree().change_scene(global.final_level)
