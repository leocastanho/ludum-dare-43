extends Area2D

var opened = false


func _on_Door_body_entered(body):
	if body.has_node("KeyPlayer") and not opened:
		$AnimationPlayer.play("Open")
		opened = true
		$Openning.play()
