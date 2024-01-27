extends Node2D

@export var sprite: Sprite2D
@export var chop: AudioStreamPlayer2D
@export var fall: AudioStreamPlayer2D

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
	chop.play()
	$health/ProgressBar.value = treeHealth*33
	if treeHealth == 0:
		fall.play()
		var newLog = log.instantiate()
		newLog.position = global_position
		get_parent().add_child(newLog)
		sprite.visible = false
		$Area2D/CollisionShape2D.disabled = true
		$StaticBody2D/CollisionShape2D.disabled = true

func _on_fall_finished():
	queue_free()
		
func popUpHealth():
	$health/AnimationPlayer.play("healthPopup")
func popDownHeath():
	$health/AnimationPlayer.play("healthPopdown")
	
func doPopup():
	
	$treePopup/AnimationPlayer.play("popup")
	
func removePopup():
	
	$treePopup/AnimationPlayer.play("popdown")
			
