extends Node2D

# Preload your saved bird scene
var bird_node = preload("res://test/test_bird.tscn")


func _ready():
	for i in range(5):
		pigeon_spawn(Vector2(randf_range(0,960),randf_range(0,400)))
	
func pigeon_spawn(pos):
	var instance = bird_node.instantiate()
	instance.position = pos
	func _physics_process(delta):
		var speed: float = randf_range(0.6, 1.4)
		
	add_child(instance)


	
