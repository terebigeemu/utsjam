extends Node2D

var tutorial_scene = preload("res://tutorial_overlay.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.has_played_tutorial == false:
		var instance = tutorial_scene.instantiate()
		add_child(instance)
		Globals.has_played_tutorial = true
	#get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.multiplier > Globals.multiplier_record:
		Globals.multiplier_record = Globals.multiplier
