extends CanvasLayer

## class member variables go here, for example:
## var a = 2
## var b = "textvar"
#
#func _ready():
#	get_node("/root/PlayerInterface/Interface").visible = false
#	# Called when the node is added to the scene for the first time.
#	# Initialization here
#	pass
#
func _input(event):
	if (Input.is_key_pressed(KEY_ESCAPE)):
#		get_node("/root/PlayerInterface/Interface").visible = true
		get_tree().change_scene(global.main_menu)
