extends Node2D

# written by adrian

var timer_scene = preload("res://fionas_test.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = timer_scene.instantiate()
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
