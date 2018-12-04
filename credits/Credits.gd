extends CanvasLayer

func _input(event):
	if (Input.is_key_pressed(KEY_ESCAPE)):
#		get_node("/root/PlayerInterface/Interface").visible = true
		get_tree().change_scene(global.main_menu)