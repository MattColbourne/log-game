extends Node2D

@export var sprite: AnimatedSprite2D
@export var progressBar: ProgressBar

@export_category("Values")
@export var burnRate: float
@export var startFuel: float

var fuel: float
var growFactor: float = 1.0
var prevScales = []

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play()
	Global.campfire = self
	fuel = startFuel
	progressBar.value = fuel
	progressBar.max_value = startFuel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	fuel -= burnRate * delta
	progressBar.value = fuel
	if fuel < 0:
		## TODO: ADD LOSS CONDITION
		pass
		
	
func grow():
	#scale*=1.2
	#Global.camera.zoom/=1.2
	prevScales.append(scale)
	scale *= ((1+growFactor/4))
	#lobal.camera.zoom /= ((1+growFactor/4))
	
	growFactor/=2
	print(growFactor)
	



func _on_timer_timeout():
	scale -= Vector2(0.01,0.01)
	#Global.camera.zoom += Vector2(0.01,0.01)
	
	if scale.x<0.5:
		#fire stops
		pass
	if prevScales.size()>0:
		if scale<prevScales[-1]:
			growFactor*=2
			prevScales.remove_at(len(prevScales)-1)
			print(prevScales)
