extends CanvasLayer

var text_count = 0
var text
var buttons
enum WICHAREA {STORY, TUTORIAL, LEVEL1, LEVEL2, LEVEL3, FINAL}
export(WICHAREA) var wich_area = WICHAREA.STORY
var npc
var npc_count = 0
var npc_sound = 3
#var area_for_buttonB
#var language_for_area2
#var time_button_area2_pressed = 0

func _ready():
	global.player_died = false
	if get_tree().get_current_scene().name == "Tutorial":
		npc = get_node("/root/Tutorial/YSort/NPC")
	if not global.player_died:
		global.player.set_physics_process(false)
	text = get_from_json(global.text_system)
	buttons = get_from_json(global.buttons)
	global.language_on = global.ENGLISH
	if global.language_on == global.ENGLISH:
		$Popup/DialogueBox/NextButton/Label.text = buttons[0]["next"][0]
	elif global.language_on == global.PORTUGUESE:
		$Popup/DialogueBox/NextButton/Label.text = buttons[1]["next"][0]
	_on_NextButton_pressed()
	yield(get_tree().create_timer(1), "timeout")
	pop_up_show()


func get_from_json(filename):
	var file = File.new() #the file object
	file.open(filename,File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _on_NextButton_pressed():
	if global.language_on == global.ENGLISH:
		match wich_area:
			STORY:
				wich_area(0, "story")
			TUTORIAL:
				if global.player_died:
					wich_area(0, "loosing_tutorial")
				else:
					wich_area(0, "tutorial")
					if npc_sound <= 1:
						npc.get_node("AudioStreamPlayer").play()
					elif npc_sound >= 3:
						npc_sound = 0
					npc_sound += 1
			LEVEL1:
				if global.player_died:
					wich_area(0, "loosing_normal")
				else:
					wich_area(0, "level1")
			LEVEL2:
				if global.player_died:
					wich_area(0, "loosing_normal")
				else:
					wich_area(0, "level2")
			LEVEL3:
				if global.player_died:
					wich_area(0, "loosing_normal")
				else:
					wich_area(0, "level3")
			FINAL:
				wich_area(0, "final")
	elif global.language_on == global.PORTUGUESE:
		match wich_area:
			STORY:
				wich_area(1, "story")
			TUTORIAL:
				wich_area(1, "story")
			FINAL:
				wich_area(1, "story")
	text_count += 1

func wich_area(language, area):
	text_count = clamp(text_count, 0, text[language][area].size() - 1)
	$Popup/DialogueBox/Label.text = text[language][area][text_count]
	if area == "story":
		if text_count == text[0]["story"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "tutorial":
		if text_count == 7 or text_count == 11 or text_count == 12 or text_count == 14 or text_count == text[0]["tutorial"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "loosing_tutorial":
		if text_count == text[0]["loosing_tutorial"].size() - 1:
			$Popup/DialogueBox/NextButton.visible = false
			$Popup/DialogueBox/TryAgain.visible = true
	if area == "level1":
		if text_count == 0 or text_count == 1 or text_count == text[0]["level1"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "level2":
		if text_count == 0 or text_count == text[0]["level2"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "level3":
		if text_count == 2 or text_count == text[0]["level3"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false
	if area == "loosing_normal":
		if text_count == text[0]["loosing_normal"].size() - 1:
			$Popup/DialogueBox/NextButton.visible = false
			$Popup/DialogueBox/TryAgain.visible = true
	if area == "final":
		if text_count == text[0]["final"].size() - 1:
			$Popup/DialogueBox/CloseButtonFinal.visible = true
			$Popup/DialogueBox/NextButton.visible = false

func wich_area_button(language, optionA, optionB, closeA, closeB):
	$Popup/DialogueBox/OptionA/Label.text = buttons[language][optionA][0]
	$Popup/DialogueBox/OptionB/Label.text = buttons[language][optionB][0]
	$Popup/DialogueBox/CloseButtonA/Label.text = buttons[language][closeA][0]
	$Popup/DialogueBox/CloseButtonB/Label.text = buttons[language][closeB][0]

func pop_up_show():
	if not global.player_died:
		$Popup/DialogueBox/NextButton.visible = true
	$Popup.show()
	$Tween.interpolate_property($Popup, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func pop_up_hide():
	$Tween.interpolate_property($Popup, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	$Popup.hide()

func _on_CloseButtonFinal_pressed():
	pop_up_hide()
	$Popup/DialogueBox/CloseButtonFinal.visible = false
	global.player.set_physics_process(true)
	if get_tree().get_current_scene().name == "Tutorial":
		if npc_count == 0:
			npc.get_node("AnimationPlayer").play("vanishing")
			yield(npc.get_node("AnimationPlayer"), "animation_finished")
			npc.global_position = get_node("../NPCPosition2").global_position
			npc.get_node("AnimationPlayer").play("idle")
			npc_count += 1
			npc_sound = 3
		elif npc_count == 1:
			npc.get_node("AnimationPlayer").play("vanishing")
			yield(npc.get_node("AnimationPlayer"), "animation_finished")
			npc.global_position = get_node("../NPCPosition3").global_position
			npc.get_node("AnimationPlayer").play("idle")
			npc.get_node("Light2D").visible = true
			npc_count += 1
			npc_sound = 3
		elif npc_count == 2:
			npc.get_node("AnimationPlayer").play("vanishing")
			yield(npc.get_node("AnimationPlayer"), "animation_finished")
			npc.global_position = get_node("../NPCPosition4").global_position
			npc.get_node("AnimationPlayer").play("idle")
			npc_count += 1
			npc_sound = 3
			global.player.get_node("BodyLight").visible = true
			global.player.get_node("FeetLight").visible = true
		elif npc_count == 3:
			npc.get_node("AnimationPlayer").play("vanishing")
			yield(npc.get_node("AnimationPlayer"), "animation_finished")
			npc.global_position = get_node("../NPCPosition5").global_position
			npc.get_node("AnimationPlayer").play("idle")
			npc_count += 1
			npc_sound = 3
#	if area_for_buttonB == "mind_area1":
#		get_tree().change_scene(Global.level1)
#		get_node("/root/PlayerInterface/Interface").visible = true
#	if area_for_buttonB == "mind_area2":
#		get_tree().change_scene(Global.level2)
#		get_node("/root/PlayerInterface/Interface").visible = true
#	if area_for_buttonB == "mind_area3":
#		get_tree().change_scene(Global.level3)
#		get_node("/root/PlayerInterface/Interface").visible = true
#	if area_for_buttonB == "mind_area4":
#		get_tree().change_scene(Global.level4)
#		get_node("/root/PlayerInterface/Interface").visible = true
#	if area_for_buttonB == "final_area":
#		get_node("../Position2D/PortalFinalArea/CollisionShape2D").disabled = false
#	if area_for_buttonB == "boss_area":
#		get_node("..")._change_state(get_node("..").IDLE)
#		get_node("..")._next_phase(get_node("..").EASY)

#func _on_DialogueTrigger_body_entered(body):
#	if body == Global.Player:
#		text_count = 0
#		dialogue_part = NORMALDIALOGUE
#		_on_NextButton_pressed()
#		pop_up_show()

func _on_TryAgain_pressed():
	global.player.queue_free()
	var player = global.player_scene.instance()
	get_node("../YSort").add_child(player)
	pop_up_hide()
	$Popup/DialogueBox/NextButton.visible = true
	$Popup/DialogueBox/TryAgain.visible = false
