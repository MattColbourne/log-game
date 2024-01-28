extends Node2D

var num_trees = 7
@onready var screenSize = get_viewport().get_visible_rect().size
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if num_trees < 7:
		var tree = preload("res://tree.tscn")
		var instance = tree.instantiate()
		var rng = RandomNumberGenerator.new()
		var x = rng.randi_range(0, screenSize.x)
		var y = rng.randi_range(0, screenSize.y)
		instance.position = Vector2(x,y)
		add_child(instance)
		num_trees += 1
	
	
	
func decrement():
	num_trees -= 1
