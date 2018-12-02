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
		var pop_up = global.pop_label.instance()
		get_node("/root/BlindLevelModel/PlayerInterface").add_child(pop_up)
		get_node("/root/BlindLevelModel/PlayerInterface/pop_label").pop("You've found the key!")
#		get_node("/root/BlindLevelModel/PlayerInterface/Control/Label2").text = "You got the key"
		yield(get_node("PickingUp"), "finished")
#		get_node("/root/BlindLevelModel/PlayerInterface/Control/Label2").text = ""
		queue_free()