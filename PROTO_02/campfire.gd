extends Node2D

@export var sprite: AnimatedSprite2D
@export var progressBar: ProgressBar
@export var player: Node2D
@export var text: CanvasLayer

@export_category("Values")
@export var burnRate: float
@export var startFuel: float

var fuel: float
var growFactor: float = 1.0
var prevScales = []
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():	
	text.hide()
	sprite.play()
	Global.campfire = self
	fuel = startFuel
	#progressBar.value = fuel
	progressBar.max_value = scale.x*20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if alive:
		#fuel -= burnRate * delta
		#fuel = scale.x*20
		
		print(progressBar.max_value)
		#progressBar.value = fuel
		if progressBar.value <= 0:
			die()
		
	
func grow():
	#scale*=1.2
	#Global.camera.zoom/=1.2
	prevScales.append(scale)
	#scale *= ((1+growFactor/4))
	progressBar.value += 5
	#lobal.camera.zoom /= ((1+growFactor/4))
	#growFactor/2
	if scale.x*20 > progressBar.max_value:
		scale = Vector2(progressBar.max_value/20, progressBar.max_value/20)
	

func _on_timer_timeout():
	#if scale.x > 0:
		#scale -= Vector2(0.018,0.018)
	progressBar.value -= 0.5
	
	
	if scale.x<0.5:
		#fire stops
		pass
	if prevScales.size()>0:
		if scale<prevScales[-1]:
			growFactor*=2
			prevScales.remove_at(len(prevScales)-1)
			
func die():
	player.canMove = false
	player.velocity = Vector2.ZERO
	alive = false
	text.show()
	Global.dead = true
	var d = await player.handleDeath()
	player.get_node("AudioStreamPlayer2D").play()
	#player.get_node("AnimationPlayer").play("death")

	
