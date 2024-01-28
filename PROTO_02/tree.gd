extends Node2D

@export var sprite: Sprite2D

var log = preload("res://log.tscn")
var spriteRects = [Rect2(0,0,96,96), Rect2(96, 0, 96, 96), Rect2(192, 0, 96, 96)]


var treeHealth = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = int(position.y/10)
	spriteRects.shuffle()
	sprite.region_rect = spriteRects[0]
	
	$health.scale = Vector2.ZERO
	$treePopup.scale = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func takeDamage():
	treeHealth -=1
	$health/ProgressBar.value = treeHealth*33
	if treeHealth == 0:
		var newLog = log.instantiate()
		newLog.position = global_position
		get_parent().add_child(newLog)
		#Global.treesDestroyedList.append(self)
		
		queue_free()
		
func popUpHealth():
	$health/AnimationPlayer.play("healthPopup")
func popDownHeath():
	$health/AnimationPlayer.play("healthPopdown")
	
func doPopup():
	
	#var alreadyshown = false
	#for i in range(get_child_count()):
	#	if get_child(i).name.contains("treePopup"):
	#		alreadyshown = true
	#		break
	#if alreadyshown == false:
	#	add_child(popup.instantiate())
	$treePopup/AnimationPlayer.play("popup")
	
func removePopup():
	#for i in range(get_child_count()):
	#	if get_child(i).name.contains("treePopup"):
	#		get_child(i).popDown()
	#		break
	$treePopup/AnimationPlayer.play("popdown")
			
