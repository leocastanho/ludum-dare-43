extends Area2D

#arrumar o path depois
onready var key = preload("res://door_and_key/KeyPlayer.tscn")
var keyPickedUp = false


func _on_Key_body_entered(body):
	if not keyPickedUp:
		keyPickedUp = true
		var key_on_player = key.instance()
		body.add_child(key_on_player)
		$PickingUp.play()
		yield(get_node("PickingUp"), "finished")
		queue_free()