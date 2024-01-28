extends Node2D

var followPlayer = false
var playAnim = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$popups.scale = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if followPlayer == true:
		position = Global.playerPos
		
func drop(nearCampfire):
	if nearCampfire == false:
		followPlayer = false
		position.y += 10
	else:
		#put in fire
		Global.campfire.grow()
		queue_free()
		
func popUp():
	if $animPlayer.is_playing()==false:
		$animPlayer.play("popup")
	else:
		playAnim = "popup"

func popDown():
	if $animPlayer.is_playing()==false and $popups.scale.x == 2:
		$animPlayer.play("popdown")
	else:
		playAnim = "popdown"
	
	


func _on_anim_player_animation_finished(anim_name):
	if playAnim != null:
		$animPlayer.play(playAnim)
		playAnim = null
