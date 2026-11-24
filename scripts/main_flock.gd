extends Node2D

var flock_scene = preload("res://test/test_flock_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = flock_scene.instantiate()
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
