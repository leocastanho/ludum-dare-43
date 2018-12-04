extends KinematicBody2D

const SPEED = 4
const MAX_SPEED = 130
const FRICTION = 0.15
var motion = Vector2()

var playerMoving = false
var velocityMultiplier = 1
var stepsPlayng = false

func _ready():
	if get_tree().get_current_scene().name == "Tutorial" and not global.passed_first_area_on_tuto:
		$BodyLight.visible = false
		$FeetLight.visible = false
	if not global.player_died:
		global.payer_spawn_position = position
	else:
		position = global.payer_spawn_position
		for key in get_node("../../Keys").get_children():
			key.reset_key()
	global.player_died = false
	OS.center_window()
	global.player = self
	yield(get_tree().create_timer(50), "timeout")
	$PlayerBreathing.play()

func _physics_process(delta):
	update_motion(delta)
	move_and_slide(motion * velocityMultiplier)
	if motion.x > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true

func _input(event):
	if Input.is_action_just_pressed("Monsters"):
		$PlayerTalking.stream = global.calling_monsters
		$PlayerTalking.play()
		yield($PlayerTalking, "finished")
		if get_tree().get_current_scene().name == "Tutorial":
			for sheep in get_node("..").get_children():
				if sheep is Area2D:
					var distance_between = sheep.global_position.distance_to(global_position)
					if distance_between <= 200:
						sheep.play_song()
		else:
			for monster in get_node("..").get_children():
				if monster is Area2D:
					var distance_between = monster.global_position.distance_to(global_position)
					if distance_between <= 300:
						monster.play_song()
	if Input.is_action_just_pressed("Key"):
		$PlayerTalking.stream = global.calling_key
		$PlayerTalking.play()
		yield($PlayerTalking, "finished")
		if get_node("../../Keys") != null:
			for key in get_node("../../Keys").get_children():
				if not key.keyPickedUp:
					key.get_node("AudioStreamPlayer2D").play()
	if Input.is_action_just_pressed("Door"):
		$PlayerTalking.stream = global.calling_door
		$PlayerTalking.play()
		yield($PlayerTalking, "finished")
		if get_node("../../Doors") != null:
			for door in get_node("../../Doors").get_children():
				if not door.opened:
					door.get_node("AudioStreamPlayer2D").play()

func update_motion(delta):
# Option 2: Jean-François movement with no priority. I like this one better, looks cleaner

#	look_at(get_global_mouse_position())
	var velocity = Vector2()

	velocity.x += int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	velocity.y += int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
#	if onThebox:
#		velocity = velocity.normalized() * speedOnBox
#	else:
	velocity = velocity.normalized() * SPEED
	if velocity.x != 0 || velocity.y != 0:
		playerMoving = true
		$AnimatedSprite.play("walk_right")
		if not $PlayerSteps.is_playing() and not stepsPlayng:
			$PlayerSteps.play()
			stepsPlayng = true
			yield(get_tree().create_timer(0.52), "timeout")
#			yield(get_node("AudioStreamPlayer"), "finished")
			$PlayerSteps.stop()
			stepsPlayng = false
	else:
		playerMoving = false
		$AnimatedSprite.play("idle")
		$PlayerSteps.stop()


	if not velocity == Vector2(): #and not onThebox:
		motion += velocity
		motion = motion.clamped(MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
		motion.y = lerp(motion.y, 0, FRICTION)

func death(normal_game):
	if normal_game:
		set_physics_process(false)
		$AnimatedSprite.play("die")
		$PlayerBreathing.stop()
		get_node("../../AudioStreamPlayer").play()
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.stop()
		yield(get_tree().create_timer(0.5), "timeout")
		$AnimationPlayer.play("blink_death")
	else:
		set_physics_process(false)
		$AnimatedSprite.play("hurt")
		$PlayerBreathing.stop()
		get_node("../../AudioStreamPlayer").play()
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.play("idle")