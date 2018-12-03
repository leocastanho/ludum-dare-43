extends Node2D

var tuto_part_two_activated = false
var tuto_part_three_activated = false
var tuto_part_four_activated = false
var tuto_part_five_activated = false
onready var text_system = $text_system

func _ready():
	get_node("/root/MusicBG").volume_db = -22

func restart():
	global.player.death(false)
	global.player_died = true
	text_system.text_count = 0
	text_system._on_NextButton_pressed()
	text_system.pop_up_show()

func _on_TutorialPart2_body_entered(body):
	if not tuto_part_two_activated and body == global.player:
		text_system.text_count = 8
		global.player.get_node("AnimatedSprite").play("idle")
		global.player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		tuto_part_two_activated = true

func _on_TutorialPart3_body_entered(body):
	if not tuto_part_three_activated and body == global.player:
		$CanvasModulate/AnimationPlayer.play("toggle_light_off")
		text_system.text_count = 12
		global.player.get_node("AnimatedSprite").play("idle")
		global.player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		global.payer_spawn_position = $PlayerSpawnPosition2.position
		tuto_part_three_activated = true
		global.passed_first_area_on_tuto = true

func _on_TutorialPart4_body_entered(body):
	if not tuto_part_four_activated and body == global.player:
		text_system.text_count = 13
		global.player.get_node("AnimatedSprite").play("idle")
		global.player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		global.payer_spawn_position = $PlayerSpawnPosition3.position
		tuto_part_four_activated = true

func _on_TutorialPart5_body_entered(body):
	if not tuto_part_five_activated and body == global.player:
		text_system.text_count = 15
		global.player.get_node("AnimatedSprite").play("idle")
		global.player.set_physics_process(false)
		text_system._on_NextButton_pressed()
		text_system.pop_up_show()
		tuto_part_five_activated = true

func _on_EndOfTutorial_body_entered(body):
	get_tree().change_scene(global.level1)
