extends CharacterBody2D


@export var speed = 200

var treesInAreaArray = []
var currentlyHeldLog = null
var logsInArea = []
var nearCampfire = false
var pressed = ""
var isChopping = false;

@onready var _animation_player = $AnimationPlayer

func _process(delta):
	if isChopping: pass
	else:
		z_index = int(position.y/10)
		Global.playerPos = global_position
		if Input.is_action_just_pressed("swing_axe") and treesInAreaArray.size()>0:
			treesInAreaArray[-1].takeDamage()
		if Input.is_action_just_pressed("pickup") and currentlyHeldLog == null and logsInArea.size()>0:
			if is_instance_valid(logsInArea[-1]):
				currentlyHeldLog = logsInArea[-1]
				
				currentlyHeldLog.popDown()
				logsInArea[-1].followPlayer = true
				speed = 150
		elif Input.is_action_just_pressed("pickup") and currentlyHeldLog != null:
			currentlyHeldLog.drop(nearCampfire)
			logsInArea.insert(0,currentlyHeldLog)
			logsInArea.remove_at(len(logsInArea)-1)
			currentlyHeldLog = null
			speed = 200
		
		if Input.is_action_pressed("left"):
			_animation_player.play("walk_left")
	
		elif Input.is_action_pressed("right"):
			_animation_player.play("walk_right")
	
		elif Input.is_action_pressed("up"):
			_animation_player.play("walk_up")
	
		elif Input.is_action_pressed("down"):
			_animation_player.play("walk_down")
			
		else:
			_animation_player.stop()
	
		if Input.is_action_just_pressed("swing_axe"):
			if($Sprite2D.frame < 7):
				handleSwing("chop_up")
				
			elif($Sprite2D.frame < 14):
				handleSwing("chop_left")
				
			elif($Sprite2D.frame < 21):
				handleSwing("chop_down")
				
			elif($Sprite2D.frame < 28) :
				handleSwing("chop_right")
			
			elif($Sprite2D.frame < 35):
				handleSwing("chop_up")
				
			elif($Sprite2D.frame < 42):
				handleSwing("chop_left")
				
			elif($Sprite2D.frame < 49):
				handleSwing("chop_down")
				
			elif($Sprite2D.frame < 56) :
				handleSwing("chop_right")
				
		
		
func handleSwing(dir):
	isChopping = true
	_animation_player.play(dir)
	await get_tree().create_timer(0.6).timeout
	isChopping = false;
	_animation_player.stop()
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("tree"):
		treesInAreaArray.append(area.get_parent())
		area.get_parent().doPopup()
		area.get_parent().popUpHealth()
	elif area.is_in_group("log"):
		logsInArea.append(area.get_parent())
		area.get_parent().popUp()
	elif area.is_in_group("campfire"):
		nearCampfire = true
		if currentlyHeldLog != null:
			currentlyHeldLog.popUp2()
		

func _on_area_2d_area_exited(area):
	if area.is_in_group("tree"):
		for i in range(treesInAreaArray.size()):
			if treesInAreaArray[i] == area.get_parent():
				treesInAreaArray.remove_at(i)
				area.get_parent().removePopup()
				area.get_parent().popDownHeath()
				break
	
	elif area.is_in_group("campfire"):
		nearCampfire = false
		if currentlyHeldLog != null:
			currentlyHeldLog.popDown2()
		
	elif area.is_in_group("log"):
		area.get_parent().popDown()

