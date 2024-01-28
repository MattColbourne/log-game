extends Node2D

@export var scorePerSec: int
@export var display: Label

var score: int

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not Global.dead: score += scorePerSec*delta
	display.text = str(score)
