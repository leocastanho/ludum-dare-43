tool
extends Node2D

func play_song():
	if not $AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()

func _on_Monster_body_entered(body):
	$Light2D.visible = true
	global.player.death()

#func _draw():
#	draw_circle(Vector2(0,0), 190, Color(1,1,1,0.3))