tool
extends Node2D

func play_song():
	if not $AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()

func _on_Monster_body_entered(body):
	if get_tree().get_current_scene().name == "Tutorial":
		get_node("../../..").restart()
	else:
		$Light2D.visible = true
		get_node("../../..").restart()

func _draw():
	if global.show_sound_circle:
		draw_circle(Vector2(0,0), $AudioStreamPlayer2D.max_distance - 70, Color(1,1,1,0.3))