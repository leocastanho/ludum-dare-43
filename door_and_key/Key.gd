extends Area2D

#arrumar o path depois
var keyPickedUp = false
export (NodePath) var wich_door
onready var wich_door_node = get_node(wich_door)

func _on_Key_body_entered(body):
	if not keyPickedUp and body == global.player:
		visible = false
		keyPickedUp = true
		wich_door_node.got_key = true
		$PickingUp.play()
		var pop_up = global.pop_label.instance()
		get_node("../../text_system").add_child(pop_up)
		get_node("../../text_system/pop_label").pop("You've found the key!")
		yield(get_node("PickingUp"), "finished")
		queue_free()