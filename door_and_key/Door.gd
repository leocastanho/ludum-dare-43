extends Area2D

var opened = false
var closed = false
var got_key = false

func _on_Door_body_entered(body):
	if got_key and not opened and body == global.player:
		$AnimationPlayer.play("Open")
		opened = true
		$Openning.play()

func _on_CloseDoor_body_entered(body):
	if get_tree().get_current_scene().name == "Tutorial" and not closed:
		$AnimationPlayer.play("Close")
		closed = true


