extends Node2D

var final_dialogue = false

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
	player.get_node("PlayerFalling").stream = global.hitting_ground
	player.get_node("PlayerFalling").play()

func restart():
	var player = global.player
	player.death(true)
	global.player_died = true
	text_system.text_count = 0
	text_system._on_NextButton_pressed()
	text_system.pop_up_show()

func _on_FinalDialogue_body_entered(body):
	if body == global.player:
		var player = global.player
		if not final_dialogue and body == global.player:
			text_system.text_count = 3
			player.get_node("AnimatedSprite").play("idle")
			player.set_physics_process(false)
			text_system._on_NextButton_pressed()
			text_system.pop_up_show()
			final_dialogue = true
			text_system.got_the_light = true	