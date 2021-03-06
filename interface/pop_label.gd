extends Control

export (Vector2) var final_scale = Vector2(1.5, 1.5)
export (float) var float_distance = 100
export (float) var duration = 0.25

#func _ready():
#	pop("teste")
##	OS.center_window()
	
func pop(text):
	$label.text = text
	$tween.interpolate_property($label, "rect_scale", rect_scale, final_scale,
			duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			
	$tween.start()
	yield($tween, "tween_completed")
	
	$tween.interpolate_property(self, "rect_position", rect_position, 
			rect_position + Vector2(0, -float_distance), duration, Tween.TRANS_BACK,
			Tween.EASE_IN)
	var transparent = modulate
	transparent.a = 0.0
	$tween.interpolate_property(self, "modulate", modulate, transparent,
			duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$tween.start()
	yield($tween, "tween_completed")
	queue_free()
