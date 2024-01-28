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
		if x < (screenSize.x / 2) + 50 and x > (screenSize.x / 2) - 50:
			x -= 100
		if x < 25: x += 50
		if x > screenSize.x - 25: x -= 50
		var y = rng.randi_range(0, screenSize.y)
		if y < (screenSize.y / 2) + 50 and y > (screenSize.y / 2) - 50:
			y += 100
		if y < 25: y += 50
		if y > screenSize.y - 25: y -= 50
		
		instance.position = Vector2(x,y)
		add_child(instance)
		num_trees += 1
	
	
func decrement():
	num_trees -= 1
