extends Area2D

func _on_WaterArea_body_entered(body):
	global.player.get_node("PlayerSteps").stream = global.water_steps


func _on_WaterArea_body_exited(body):
	global.player.get_node("PlayerSteps").stream = global.normal_steps
