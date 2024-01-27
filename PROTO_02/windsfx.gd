extends Node2D

@export_category("Nodes")
@export var player: Node2D
@export var fire: Node2D
@export var campfireSFX: AudioStreamPlayer2D
@export var windSFX: AudioStreamPlayer2D
@export_category("Distances")
@export var windDist: int
@export var windMaxVol: int
@export var fireMaxVol: int
@export var windMinVol: int
@export var fireMinVol: int

var dist: float
# Called when the node enters the scene tree for the first time.
func _ready():
	windSFX.volume_db = windMinVol
	campfireSFX.volume_db = fireMaxVol
	windSFX.play()
	campfireSFX.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dist = player.position.distance_to(fire.position)
	if dist > windDist:
		enable_wind()
	if dist < windDist:
		disable_wind()
	
func enable_wind():
	windSFX.volume_db = windMaxVol
	campfireSFX.volume_db = fireMinVol
	
func disable_wind():
	windSFX.volume_db = windMinVol
	campfireSFX.volume_db = fireMaxVol
	
	
