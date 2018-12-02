tool
extends Node2D

func play_song():
#	var distance_between = position.distance_to(global.player.position)
#	if distance_between <= 300:
	$AudioStreamPlayer2D.play()

func _on_Monster_body_entered(body):
	$Light2D.visible = true
	global.player.death()

func _draw():
	draw_circle(Vector2(0,0), 190, Color(1,1,1,0.3))